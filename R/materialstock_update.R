
#' erp删除清空表
#'
#'
#' @param dms_token
#'
#' @return
#' @export
#'
#' @examples
#' materialstock_tm_delete()
materialstock_tm_delete <- function(dms_token) {
  sql=paste0("
truncate table rds_erp_src_t_MATERIALSTOCK_update")
  res <-tsda::sql_delete2(token =dms_token ,
                          sql_str = sql)

  return(res)

}


#' erp备份表
#'
#'
#' @param dms_token
#'
#' @return
#' @export
#'
#' @examples
#' materialstock_tm_bak()
materialstock_tm_bak <- function(dms_token) {
  sql=paste0("
insert into rds_erp_src_t_MATERIALSTOCK_bak
select　d.FNUMBER AS FUSEORGID,a.fnumber ,
b.FMINSTOCK ,b.FSAFESTOCK,b.FMAXSTOCK,
b.FIsEnableMinStock,b.FIsEnableSafeStock ,b.FIsEnableMaxStock,
c.FMINSTOCK ,c.FSAFESTOCK,c.FMAXSTOCK,
case c.FIsEnableMinStock when '是' then '1' when '否' then '0'  end as FIsEnableMinStock,
case c.FIsEnableSafeStock when '是' then '1' when '否' then '0'  end as FIsEnableSafeStock,
case c.FIsEnableMaxStock when '是' then '1' when '否' then '0'  end as FIsEnableMaxStock,
GETDATE() AS FUPDATETIME,E.FPLANSAFESTOCKQTY AS FPLANSAFESTOCKQTY,C.FPLANSAFESTOCKQTY AS FPLANSAFESTOCKQTY_NEW
 from  t_BD_Material　ａ
inner join t_BD_MaterialStock b　on a.FMATERIALID =b.FMATERIALID
inner join T_ORG_ORGANIZATIONS d on a.FUSEORGID=d.FORGID
inner　join　rds_erp_src_t_MATERIALSTOCK_update　c on a.FNUMBER=c.FMATERIALNUMBER and c.FUSEORGID=d.fnumber
inner join T_BD_MATERIALPLAN e on a.FMATERIALID=e.FMATERIALID")
  res <-tsda::sql_insert2(token =dms_token ,sql_str = sql)

  return(res)

}

#' erp更新物料库存
#'
#'
#' @param dms_token
#'
#' @return
#' @export
#'
#' @examples
#' materialstock_tm_update()
materialstock_tm_update <- function(dms_token) {
  sql=paste0("
UPDATE b
SET 　b.FMINSTOCK =c.FMINSTOCK,
b.FSAFESTOCK = c.FSAFESTOCK,
b.FMAXSTOCK=c.FMAXSTOCK,
b.FIsEnableMinStock=case c.FIsEnableMinStock when '是' then '1' when '否' then '0'  end ,
b.FIsEnableSafeStock =case c.FIsEnableSafeStock when '是' then '1' when '否' then '0'  end ,
b.FIsEnableMaxStock=case c.FIsEnableMaxStock when '是' then '1' when '否' then '0'  end
 from  t_BD_Material　ａ
inner join t_BD_MaterialStock b　on a.FMATERIALID =b.FMATERIALID
inner join T_ORG_ORGANIZATIONS d on a.FUSEORGID=d.FORGID
inner　join　rds_erp_src_t_MATERIALSTOCK_update　c on a.FNUMBER=c.FMATERIALNUMBER  and c.FUSEORGID=d.fnumber
")
  tsda::sql_update2(token =dms_token ,sql_str = sql)
  #更新计划属性安全库存
  sql2=paste0("
  UPDATE E
SET 　E.FPLANSAFESTOCKQTY=C.FPLANSAFESTOCKQTY
 from  t_BD_Material　ａ
inner join t_BD_MaterialStock b　on a.FMATERIALID =b.FMATERIALID
inner join T_ORG_ORGANIZATIONS d on a.FUSEORGID=d.FORGID
inner　join　rds_erp_src_t_MATERIALSTOCK_update　c on a.FNUMBER=c.FMATERIALNUMBER  and c.FUSEORGID=d.fnumber
inner join T_BD_MATERIALPLAN e on a.FMATERIALID=e.FMATERIALID
")
  res <-tsda::sql_update2(token =dms_token ,sql_str = sql2)


  return(res)

}
