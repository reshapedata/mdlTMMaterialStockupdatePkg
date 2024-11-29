
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
select　'999' AS FUSEORGID,a.fnumber ,b.FMINSTOCK ,b.FMAXSTOCK,b.FSAFESTOCK,
c.FMINSTOCK,c.FMAXSTOCK,c.FSAFESTOCK ,GETDATE() AS FUPDATETIME
 from  t_BD_Material　ａ
inner join t_BD_MaterialStock b　on a.FMATERIALID =b.FMATERIALID
inner　join　rds_erp_src_t_MATERIALSTOCK_update　c on a.FNUMBER=c.FMATERIALNUMBER
where  a.FUSEORGID=124854")
  res <-tsda::sql_insert2(token =dms_token ,sql_str = sql)

  return(res)

}

#' erp更新物料kuncun
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
UPDATE B
SET 　b.FMINSTOCK =c.FMINSTOCK,
b.FMAXSTOCK=c.FMAXSTOCK,
b.FSAFESTOCK = c.FSAFESTOCK
 from  t_BD_Material　ａ
inner join t_BD_MaterialStock b　on a.FMATERIALID =b.FMATERIALID
inner　join　rds_erp_src_t_MATERIALSTOCK_update　c on a.FNUMBER=c.FMATERIALNUMBER
where  a.FUSEORGID=124854")
  res <-tsda::sql_update2(token =dms_token ,sql_str = sql)


  return(res)

}
