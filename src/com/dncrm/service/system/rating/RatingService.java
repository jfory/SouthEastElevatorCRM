package com.dncrm.service.system.rating;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("ratingService")
public class RatingService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public List<PageData> listPdPageRating(Page page) throws Exception{
		return (List<PageData>) dao.findForList("RatingMapper.ratinglistPage", page);
	}
	
	public List<PageData> findAllRating() throws Exception{
		return (List<PageData>) dao.findForList("RatingMapper.findAllRating", "");
	}
	
	public void ratingAdd(PageData pd) throws Exception{
		dao.save("RatingMapper.ratingAdd", pd);
	}
	
	public List<PageData> existsRating(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("RatingMapper.existsRating", pd);
	}
	
	public List<PageData> findRatingById(String id) throws Exception{
		return (List<PageData>) dao.findForList("RatingMapper.findRatingById", id);
	}
	
	public void ratingUpdate(PageData pd) throws Exception{
		dao.update("RatingMapper.ratingUpdate", pd);
	}
	
	public void ratingDeleteById(String id) throws Exception{
		dao.delete("RatingMapper.ratingDeleteById", id);
	}
	
	public void ratingDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("RatingMapper.ratingDeleteAll", ArrayDATA_IDS);
	}
}
