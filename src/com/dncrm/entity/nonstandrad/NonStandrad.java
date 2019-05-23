package com.dncrm.entity.nonstandrad;


import java.util.Arrays;

public class NonStandrad {
	private String NonUpload;//
	private String MODELS_ID;//
	private String JDK;//井道宽
	private String JDS;//井道深
	private String item_id;//井道深
    private String non_standrad_id;//
    private String project_name;//
    private String project_address;//
    private String project_area;//
    private String subsidiary_company;//
    private String operate_id;//
    private String operate_date;//
    private String lift_name;//
    private String lift_speed;//
    private String traveling_height;//
    private String opening_width;//
    private String rated_load;//
    private String pit_depth;//
    private String well_depth;//
    private String car_size;
    private String lift_c;//
    private String lift_z;//
    private String lift_m;//
    private String headroom_height;//
    private String lift_num;//
    private String lift_nos;//
    private String lift_angle;//
    private String step_width;//
    private String instance_status;//
    private String instance_id;//
    private String[] detail_id;//
    private String master_id;//
    private String TJTTH;//土建图图号
    private String NON_BZ;//备注
    private String car_height;//轿厢高度
    private String[] nonstandrad_describe;//非标描述
    private String[] nonstandrad_spec;//规格
    private String[] nonstandrad_price;//价格
    private String[] nonstandrad_date;//交货期
    private String[] nonstandrad_cost;//采购评估成本价格
    private String[] nonstandrad_handle;//技术处理
    private String[] nonstandrad_cycle;//采购周期
    private String[] nonstandrad_CJ;//差价
    private String[] nonstandrad_JCB;//加成本
    private String[] nonstandrad_JJ;//加价
    private String[] nonstandrad_JLDW;//计量单位
    private String[] nonstandrad_DTYL;//单台用量
    private String[] nonstandrad_DTBJ;//单台报价
    private String[] nonstandrad_ZJ;//总价
    private String[] nonstandrad_KDZ;//可打折
    private String[] nonstandrad_BZ;//备注
    private String[] nonstandrad_valid;//备注
    
//    新添加
    private String BZ_KMXS;
	private String BZ_SPTJ;
    
    public String getBZ_KMXS() {
		return BZ_KMXS;
	}

	public void setBZ_KMXS(String bZ_KMXS) {
		BZ_KMXS = bZ_KMXS;
	}

	public String getBZ_SPTJ() {
		return BZ_SPTJ;
	}

	public void setBZ_SPTJ(String bZ_SPTJ) {
		BZ_SPTJ = bZ_SPTJ;
	}
    

    public String getJDK() {
        return JDK;
    }

    public void setJDK(String JDK) {
        this.JDK = JDK;
    }

    public String getJDS() {
        return JDS;
    }

    public String getItem_id() {
        return item_id;
    }

    public void setItem_id(String item_id) {
        this.item_id = item_id;
    }

    public void setJDS(String JDS) {
        this.JDS = JDS;
    }

    public String getMODELS_ID() {
        return MODELS_ID;

    }

    public void setMODELS_ID(String MODELS_ID) {
        this.MODELS_ID = MODELS_ID;
    }

    public String[] getNonstandrad_cost() {
        return nonstandrad_cost;
    }

    public void setNonstandrad_cost(String[] nonstandrad_cost) {
        this.nonstandrad_cost = nonstandrad_cost;
    }

    public String getNon_standrad_id() {
        return non_standrad_id;
    }

    public void setNon_standrad_id(String non_standrad_id) {
        this.non_standrad_id = non_standrad_id;
    }
    
    public String getNonUpload() {
        return NonUpload;
    }

    public void setNonUpload(String NonUpload) {
        this.NonUpload = NonUpload;
    }

    public String getProject_name() {
        return project_name;
    }

    public void setProject_name(String project_name) {
        this.project_name = project_name;
    }

    public String getProject_address() {
        return project_address;
    }

    public void setProject_address(String project_address) {
        this.project_address = project_address;
    }

    public String getProject_area() {
        return project_area;
    }

    public void setProject_area(String project_area) {
        this.project_area = project_area;
    }

    public String getSubsidiary_company() {
        return subsidiary_company;
    }

    public void setSubsidiary_company(String subsidiary_company) {
        this.subsidiary_company = subsidiary_company;
    }

    public String getOperate_id() {
        return operate_id;
    }

    public void setOperate_id(String operate_id) {
        this.operate_id = operate_id;
    }

    public String getOperate_date() {
        return operate_date;
    }

    public void setOperate_date(String operate_date) {
        this.operate_date = operate_date;
    }

    public String getLift_name() {
        return lift_name;
    }

    public void setLift_name(String lift_name) {
        this.lift_name = lift_name;
    }

    public String getLift_speed() {
        return lift_speed;
    }

    public void setLift_speed(String lift_speed) {
        this.lift_speed = lift_speed;
    }

    public String getTraveling_height() {
        return traveling_height;
    }

    public void setTraveling_height(String traveling_height) {
        this.traveling_height = traveling_height;
    }

    public String getOpening_width() {
        return opening_width;
    }

    public void setOpening_width(String opening_width) {
        this.opening_width = opening_width;
    }

    public String getRated_load() {
        return rated_load;
    }

    public void setRated_load(String rated_load) {
        this.rated_load = rated_load;
    }

    public String getPit_depth() {
        return pit_depth;
    }

    public void setPit_depth(String pit_depth) {
        this.pit_depth = pit_depth;
    }

    public String getWell_depth() {
        return well_depth;
    }

    public void setWell_depth(String well_depth) {
        this.well_depth = well_depth;
    }

    public String getCar_size() {
        return car_size;
    }

    public void setCar_size(String car_size) {
        this.car_size = car_size;
    }

    public String getLift_c() {
        return lift_c;
    }

    public void setLift_c(String lift_c) {
        this.lift_c = lift_c;
    }

    public String getLift_z() {
        return lift_z;
    }

    public void setLift_z(String lift_z) {
        this.lift_z = lift_z;
    }

    public String getLift_m() {
        return lift_m;
    }

    public void setLift_m(String lift_m) {
        this.lift_m = lift_m;
    }

    public String getHeadroom_height() {
        return headroom_height;
    }

    public void setHeadroom_height(String headroom_height) {
        this.headroom_height = headroom_height;
    }

    public String getLift_num() {
        return lift_num;
    }

    public void setLift_num(String lift_num) {
        this.lift_num = lift_num;
    }

    public String getLift_nos() {
        return lift_nos;
    }

    public void setLift_nos(String lift_nos) {
        this.lift_nos = lift_nos;
    }

    public String getLift_angle() {
        return lift_angle;
    }

    public void setLift_angle(String lift_angle) {
        this.lift_angle = lift_angle;
    }

    public String getStep_width() {
        return step_width;
    }

    public void setStep_width(String step_width) {
        this.step_width = step_width;
    }

    public String getInstance_status() {
        return instance_status;
    }

    public void setInstance_status(String instance_status) {
        this.instance_status = instance_status;
    }

    public String getInstance_id() {
        return instance_id;
    }

    public void setInstance_id(String instance_id) {
        this.instance_id = instance_id;
    }

    public String[] getDetail_id() {
        return detail_id;
    }

    public void setDetail_id(String[] detail_id) {
        this.detail_id = detail_id;
    }

    public String getMaster_id() {
        return master_id;
    }

    public void setMaster_id(String master_id) {
        this.master_id = master_id;
    }

    public String getTJTTH() {
		return TJTTH;
	}

	public void setTJTTH(String tJTTH) {
		TJTTH = tJTTH;
	}

	public String getCar_height() {
		return car_height;
	}

	public void setCar_height(String car_height) {
		this.car_height = car_height;
	}

	public String getNON_BZ() {
		return NON_BZ;
	}

	public void setNON_BZ(String nON_BZ) {
		NON_BZ = nON_BZ;
	}

	public String[] getNonstandrad_describe() {
        return nonstandrad_describe;
    }

    public void setNonstandrad_describe(String[] nonstandrad_describe) {
        this.nonstandrad_describe = nonstandrad_describe;
    }

    public String[] getNonstandrad_spec() {
        return nonstandrad_spec;
    }

    public void setNonstandrad_spec(String[] nonstandrad_spec) {
        this.nonstandrad_spec = nonstandrad_spec;
    }

    public String[] getNonstandrad_price() {
        return nonstandrad_price;
    }

    public void setNonstandrad_price(String[] nonstandrad_price) {
        this.nonstandrad_price = nonstandrad_price;
    }

    public String[] getNonstandrad_date() {
        return nonstandrad_date;
    }

    public void setNonstandrad_date(String[] nonstandrad_date) {
        this.nonstandrad_date = nonstandrad_date;
    }

    public String[] getNonstandrad_handle() {
        return nonstandrad_handle;
    }

    public void setNonstandrad_handle(String[] nonstandrad_handle) {
        this.nonstandrad_handle = nonstandrad_handle;
    }

    public String[] getNonstandrad_cycle() {
        return nonstandrad_cycle;
    }

    public void setNonstandrad_cycle(String[] nonstandrad_cycle) {
        this.nonstandrad_cycle = nonstandrad_cycle;
    }

    public String[] getNonstandrad_CJ() {
		return nonstandrad_CJ;
	}

	public void setNonstandrad_CJ(String[] nonstandrad_CJ) {
		this.nonstandrad_CJ = nonstandrad_CJ;
	}

	public String[] getNonstandrad_JCB() {
		return nonstandrad_JCB;
	}

	public void setNonstandrad_JCB(String[] nonstandrad_JCB) {
		this.nonstandrad_JCB = nonstandrad_JCB;
	}

	public String[] getNonstandrad_JJ() {
		return nonstandrad_JJ;
	}

	public void setNonstandrad_JJ(String[] nonstandrad_JJ) {
		this.nonstandrad_JJ = nonstandrad_JJ;
	}

	public String[] getNonstandrad_JLDW() {
		return nonstandrad_JLDW;
	}

	public void setNonstandrad_JLDW(String[] nonstandrad_JLDW) {
		this.nonstandrad_JLDW = nonstandrad_JLDW;
	}

	public String[] getNonstandrad_DTYL() {
		return nonstandrad_DTYL;
	}

	public void setNonstandrad_DTYL(String[] nonstandrad_DTYL) {
		this.nonstandrad_DTYL = nonstandrad_DTYL;
	}

	public String[] getNonstandrad_DTBJ() {
		return nonstandrad_DTBJ;
	}

	public void setNonstandrad_DTBJ(String[] nonstandrad_DTBJ) {
		this.nonstandrad_DTBJ = nonstandrad_DTBJ;
	}

	public String[] getNonstandrad_ZJ() {
		return nonstandrad_ZJ;
	}

	public void setNonstandrad_ZJ(String[] nonstandrad_ZJ) {
		this.nonstandrad_ZJ = nonstandrad_ZJ;
	}

	public String[] getNonstandrad_KDZ() {
		return nonstandrad_KDZ;
	}

	public void setNonstandrad_KDZ(String[] nonstandrad_KDZ) {
		this.nonstandrad_KDZ = nonstandrad_KDZ;
	}

	public String[] getNonstandrad_BZ() {
		return nonstandrad_BZ;
	}

	public void setNonstandrad_BZ(String[] nonstandrad_BZ) {
		this.nonstandrad_BZ = nonstandrad_BZ;
	}

	public String[] getNonstandrad_valid() {
		return nonstandrad_valid;
	}

	public void setNonstandrad_valid(String[] nonstandrad_valid) {
		this.nonstandrad_valid = nonstandrad_valid;
	}

	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        NonStandrad that = (NonStandrad) o;

        if (non_standrad_id != null ? !non_standrad_id.equals(that.non_standrad_id) : that.non_standrad_id != null)
            return false;
        if (project_name != null ? !project_name.equals(that.project_name) : that.project_name != null) return false;
        if (project_address != null ? !project_address.equals(that.project_address) : that.project_address != null)
            return false;
        if (project_area != null ? !project_area.equals(that.project_area) : that.project_area != null) return false;
        if (subsidiary_company != null ? !subsidiary_company.equals(that.subsidiary_company) : that.subsidiary_company != null)
            return false;
        if (operate_id != null ? !operate_id.equals(that.operate_id) : that.operate_id != null) return false;
        if (operate_date != null ? !operate_date.equals(that.operate_date) : that.operate_date != null) return false;
        if (lift_name != null ? !lift_name.equals(that.lift_name) : that.lift_name != null) return false;
        if (lift_speed != null ? !lift_speed.equals(that.lift_speed) : that.lift_speed != null) return false;
        if (traveling_height != null ? !traveling_height.equals(that.traveling_height) : that.traveling_height != null)
            return false;
        if (opening_width != null ? !opening_width.equals(that.opening_width) : that.opening_width != null)
            return false;
        if (rated_load != null ? !rated_load.equals(that.rated_load) : that.rated_load != null) return false;
        if (pit_depth != null ? !pit_depth.equals(that.pit_depth) : that.pit_depth != null) return false;
        if (well_depth != null ? !well_depth.equals(that.well_depth) : that.well_depth != null) return false;
        if (car_size != null ? !car_size.equals(that.car_size) : that.car_size != null) return false;
        if (lift_c != null ? !lift_c.equals(that.lift_c) : that.lift_c != null) return false;
        if (lift_z != null ? !lift_z.equals(that.lift_z) : that.lift_z != null) return false;
        if (lift_m != null ? !lift_m.equals(that.lift_m) : that.lift_m != null) return false;
        if (headroom_height != null ? !headroom_height.equals(that.headroom_height) : that.headroom_height != null)
            return false;
        if (lift_num != null ? !lift_num.equals(that.lift_num) : that.lift_num != null) return false;
        if (lift_nos != null ? !lift_nos.equals(that.lift_nos) : that.lift_nos != null) return false;
        if (lift_angle != null ? !lift_angle.equals(that.lift_angle) : that.lift_angle != null) return false;
        if (step_width != null ? !step_width.equals(that.step_width) : that.step_width != null) return false;
        if (instance_status != null ? !instance_status.equals(that.instance_status) : that.instance_status != null)
            return false;
        if (instance_id != null ? !instance_id.equals(that.instance_id) : that.instance_id != null) return false;
        // Probably incorrect - comparing Object[] arrays with Arrays.equals
        if (!Arrays.equals(detail_id, that.detail_id)) return false;
        if (master_id != null ? !master_id.equals(that.master_id) : that.master_id != null) return false;
        // Probably incorrect - comparing Object[] arrays with Arrays.equals
        if (!Arrays.equals(nonstandrad_describe, that.nonstandrad_describe)) return false;
        // Probably incorrect - comparing Object[] arrays with Arrays.equals
        if (!Arrays.equals(nonstandrad_spec, that.nonstandrad_spec)) return false;
        // Probably incorrect - comparing Object[] arrays with Arrays.equals
        if (!Arrays.equals(nonstandrad_price, that.nonstandrad_price)) return false;
        // Probably incorrect - comparing Object[] arrays with Arrays.equals
        return Arrays.equals(nonstandrad_date, that.nonstandrad_date);
    }

    @Override
    public int hashCode() {
        int result = non_standrad_id != null ? non_standrad_id.hashCode() : 0;
        result = 31 * result + (project_name != null ? project_name.hashCode() : 0);
        result = 31 * result + (project_address != null ? project_address.hashCode() : 0);
        result = 31 * result + (project_area != null ? project_area.hashCode() : 0);
        result = 31 * result + (subsidiary_company != null ? subsidiary_company.hashCode() : 0);
        result = 31 * result + (operate_id != null ? operate_id.hashCode() : 0);
        result = 31 * result + (operate_date != null ? operate_date.hashCode() : 0);
        result = 31 * result + (lift_name != null ? lift_name.hashCode() : 0);
        result = 31 * result + (lift_speed != null ? lift_speed.hashCode() : 0);
        result = 31 * result + (traveling_height != null ? traveling_height.hashCode() : 0);
        result = 31 * result + (opening_width != null ? opening_width.hashCode() : 0);
        result = 31 * result + (rated_load != null ? rated_load.hashCode() : 0);
        result = 31 * result + (pit_depth != null ? pit_depth.hashCode() : 0);
        result = 31 * result + (well_depth != null ? well_depth.hashCode() : 0);
        result = 31 * result + (car_size != null ? car_size.hashCode() : 0);
        result = 31 * result + (lift_c != null ? lift_c.hashCode() : 0);
        result = 31 * result + (lift_z != null ? lift_z.hashCode() : 0);
        result = 31 * result + (lift_m != null ? lift_m.hashCode() : 0);
        result = 31 * result + (headroom_height != null ? headroom_height.hashCode() : 0);
        result = 31 * result + (lift_num != null ? lift_num.hashCode() : 0);
        result = 31 * result + (lift_nos != null ? lift_nos.hashCode() : 0);
        result = 31 * result + (lift_angle != null ? lift_angle.hashCode() : 0);
        result = 31 * result + (step_width != null ? step_width.hashCode() : 0);
        result = 31 * result + (instance_status != null ? instance_status.hashCode() : 0);
        result = 31 * result + (instance_id != null ? instance_id.hashCode() : 0);
        result = 31 * result + Arrays.hashCode(detail_id);
        result = 31 * result + (master_id != null ? master_id.hashCode() : 0);
        result = 31 * result + Arrays.hashCode(nonstandrad_describe);
        result = 31 * result + Arrays.hashCode(nonstandrad_spec);
        result = 31 * result + Arrays.hashCode(nonstandrad_price);
        result = 31 * result + Arrays.hashCode(nonstandrad_date);
        return result;
    }
}
