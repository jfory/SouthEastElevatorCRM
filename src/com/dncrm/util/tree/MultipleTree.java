package com.dncrm.util.tree;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 多叉树类
 */
public class MultipleTree {
	/**
	 * 
	 * @param dataList
	 * @param orderType :default ID横行比较排序  1:orderNo asc 2:orderNo desc
	 * @return
	 */
	public Node  makeTreeWithOderNo(List<?> dataList,int orderType) {
		/**
		 * oderType ：
		 * default ID横行比较排序
		 * 1:orderNo asc
		 * 2:orderNo desc
		 *
		 */

		// 节点列表（映射表，用于临时存储节点对象）
		HashMap<String, Node> nodeList = new HashMap<String, Node>();
		// 根节点
		Node root = null;
		// 将结果集存入映射表（后面将借助映射表构造多叉树）
		for (Iterator<?> it = dataList.iterator(); it.hasNext();) {
			Map<?, ?> dataRecord = (Map<?, ?>) it.next();
			Node node = new Node();
			node.id = (String) dataRecord.get("id");
			node.name = (String) dataRecord.get("name");
			node.parentId = (String) dataRecord.get("parentId");
			node.orderNo = (String) dataRecord.get("orderNo");
			node.nodeType = (String) dataRecord.get("nodeType");
			node.iconSkin = (String) dataRecord.get("iconSkin");
			nodeList.put(node.id, node);
		}
		// 构造无序的多叉树
		Set<?> entrySet = nodeList.entrySet();
		for (Iterator<?> it = entrySet.iterator(); it.hasNext();) {
			Node node = (Node) ((Map.Entry) it.next()).getValue();
			if (node.parentId == null || node.parentId.equals("")||node.parentId.equals("0")) {
				root = node;
			} else {
				((Node) nodeList.get(node.parentId)).addChild(node);
			}
		}
		switch (orderType) {
		case 1:
			// 对多叉树进行横向排序 with orderNo asc
			root.sortChildrenWithOrderNoAsc();
			break;
		case 2:
			// 对多叉树进行横向排序 with orderNo desc
			root.sortChildrenWithOrderNoDesc();
			break;
		default:
			// 对多叉树进行横向排序
			root.sortChildren();
			break;
		}
		// 输出有序的树形结构的JSON字符串
		return root;
	}
}