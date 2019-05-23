package com.dncrm.service.system.indicator;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Indicator.IndicatorModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class IndicatorService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    public void insertIndicatorBatch(List<IndicatorModel> indicatorModels) throws Exception {
        dao.save("IndicatorMapper.insertIndicatorBatch", indicatorModels);
    }
}
