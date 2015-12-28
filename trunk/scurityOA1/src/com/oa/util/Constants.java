package com.oa.util;
/**
 * 打回 待处理人为填表人，需要修改
 * 拒绝 则不通过  待处理人为null
 * @author liangrui
 *
 */
public class Constants {
 public  static final String CHECK_PASS="审核通过";//用于审核结果
 public  static final String CHECK_BACK="审核打回";
 public  static final String CHECK_RUTNDOWN="审核拒绝";
 //为了查询审核记录 这里做个区分
 public  static final String BOSScHECK_BACK="BOSS打回";//老板打 回
 public  static final String BOSScHECK_RUTNDOWN="BOSS拒绝";//老板拒绝
 
 public  static final String EMP_NoSUBMIT="未提交";
 public  static final String EMP_IsSUBMIT="已提交";
// public  static final String DM_NoVOUCHER="末审核";
 public  static final String DM_PASsVOUCHER="DM已审核";
 public  static final String BOSS_PASsVOUCHER="BOSS已审核";
 public  static final String FINANCE_PASsVOUCHER="已付款";
}
