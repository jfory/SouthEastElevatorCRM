package com.dncrm.util.tree;

import java.util.Comparator;

/**
 * 节点比较器
 */
class NodeIDComparator implements Comparator<Object> {
	// 按照节点编号比较
	public int compare(Object o1, Object o2) {
		int j1 = Integer.parseInt(((Node) o1).id);
		int j2 = Integer.parseInt(((Node) o2).id);
		return (j1 < j2 ? -1 : (j1 == j2 ? 0 : 1));
	}
}

