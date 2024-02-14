#!/usr/bin/env perl
# vim: syntax=sh

# шаблон конфига для archive.get_dirs.pl archive.get_files.pl

package config; # Just naming of this package

# сколько дней будут храниться подневные таблички, не прописанные в шаблоне, при использовании config-auto
$num_days=1825;

# сколько месяцев будут храниться помесячные таблички, не прописанные в шаблоне, при использовании config-auto
$num_months=60;

@directory=( # Creates an array of directories
"/sas/ppms/data/content/data/output\n",
"/sas/ppms/data/content/data/update\n",
"/sas/ppms/data/owners/data/input/cable_b2b\n",
"/sas/ppms/data/owners/data/input/cable_tv\n",
"/sas/ppms/data/owners/data/input/iptv\n",
"/sas/ppms/data/owners/data/input/mgts\n",
"/sas/ppms/data/owners/data/input/mobile_tv\n",
"/sas/ppms/data/owners/data/input/sktv\n",
"/sas/ppms/data/owners/data/input/sputnik_tv\n",
"/sas/ppms/data/owners/data/input/vod\n"
);

# Имя файла не должно содержать Y,M,D,X
# YYYY - год в четыре символа
# YY - год в два символа
# MM - месяц
# DD - день
# X - остальные цифры
# если в имени файла нет даты - будет считаться от времени изменения файла
%scan=( # Creates a map of sas7dat files with a value [505]
'content_cov_detl_YYYYMM.sas7bdat'         => [550],
'content_d_cov_detl_YYYYMM.sas7bdat'         => [550],
'content_d_dz_detl_YYYYMM.sas7bdat'         => [550],
'content_dz_detl_YYYYMM.sas7bdat'         => [550],
'content_out_all_YYYYMM.sas7bdat'         => [550],
'content_out_d_YYYYMM.sas7bdat'         => [550],
'delta_ps_YYYYMM.sas7bdat'         => [550],
'dz_tmp_YYYYMM.sas7bdat'         => [550],
'input_d_siebel_all_YYYYMM.sas7bdat'         => [550],
'input_siebel_all_YYYYMM.sas7bdat'         => [550],
'ium_input_detl_new_YYYYMM.sas7bdat'         => [550],
'ppms_att2_YYYYMM_0.sas7bdat'         => [550],
'ppms_att2_YYYYMM.sas7bdat'         => [550],
'ppms_att2_d1_YYYYMM.sas7bdat'         => [550],
'ppms_att2_d_YYYYMM.sas7bdat'         => [550],
'ppms_att3_YYYYMM_1.sas7bdat'         => [550],
'ppms_att3_YYYYMM.sas7bdat'         => [550],
'ppms_cov_d_YYYYMM.sas7bdat'         => [550],
'ppms_cov_tmp_YYYYMM.sas7bdat'         => [550],
'ppms_cov_tmp_YYYYMM.sas7bdat'         => [550],
'ppms_dz_d_YYYYMM.sas7bdat'         => [550],
'ppms_flag2_YYYYMM_1_tst.sas7bdat'         => [550],
'ppms_flag2_YYYYMM_2_tst.sas7bdat'         => [550],
'ppms_flag2_YYYYMM_tst.sas7bdat'         => [550],
'ppms_flag3_YYYYMM.sas7bdat'         => [550],
'ppms_flag3_all_YYYYMM.sas7bdat'         => [550],
'ppms_sclc_YYYYMM.sas7bdat'         => [550],
'ppms_siebel_d_YYYYMM.sas7bdat'         => [550],
'rekl_err1_YYYYMM.sas7bdat'         => [550],
'rekl_err_YYYYMM.sas7bdat'         => [550],
'rekl_err2_YYYYMM.sas7bdat'         => [550],
'content_claim_YYYYMM.sas7bdat'         => [550],
'content_claim_d_YYYYMM.sas7bdat'         => [550],
'content_com_det_YYYYMM.sas7bdat'         => [550],
'content_com_det_d_YYYYMM.sas7bdat'         => [550],
'content_cov_YYYYMM.sas7bdat'         => [550],
'content_cov_d_YYYYMM.sas7bdat'         => [550],
'content_fdeb_YYYYMM.sas7bdat'         => [550],
'content_fdeb_d_YYYYMM.sas7bdat'         => [550],
'content_tech_det_YYYYMM.sas7bdat'         => [550],
'abon_base_YYYYMM.sas7bdat'         => [550],
'atv_YYYYMM.sas7bdat'         => [550],
'atv_channel_YYYYMM.sas7bdat'         => [550],
'atv_first_YYYYMM.sas7bdat'         => [550],
'atv_first_block_YYYYMM.sas7bdat'         => [550],
'atv_first_cls_YYYYMM.sas7bdat'         => [550],
'atv_first_to_calc_YYYYMM.sas7bdat'         => [550],
'ctv_add_YYYYMM.sas7bdat'         => [550],
'ctv_add_channel_YYYYMM.sas7bdat'         => [550],
'ctv_add_first_YYYYMM.sas7bdat'         => [550],
'ctv_add_first_cls_YYYYMM.sas7bdat'         => [550],
'ctv_add_first_to_calc_YYYYMM.sas7bdat'         => [550],
'ctv_add_first_zero_YYYYMM.sas7bdat'         => [550],
'ctv_base_YYYYMM.sas7bdat'         => [550],
'ctv_base_channel_YYYYMM.sas7bdat'         => [550],
'ctv_base_first_YYYYMM.sas7bdat'         => [550],
'ctv_base_first_block_YYYYMM.sas7bdat'         => [550],
'ctv_base_first_cls_YYYYMM.sas7bdat'         => [550],
'ctv_base_first_to_calc_YYYYMM.sas7bdat'         => [550],
'ctv_income_YYYYMM.sas7bdat'         => [550],
'ctv_income_channel_YYYYMM.sas7bdat'         => [550],
'ctv_income_first_YYYYMM.sas7bdat'         => [550],
'owner_tv_m1_YYYYMM.sas7bdat'         => [550],
'owner_tv_m1_YYYYMM_short.sas7bdat'         => [550],
'owner_tv_m3_YYYYMM.sas7bdat'         => [550],
'svod_m1_YYYYMM.sas7bdat'         => [550],
'svod_m3_YYYYMM.sas7bdat'         => [550],
'active_days_daily_YYYYMM.sas7bdat'         => [550],
'mob_abon_base_activ_YYYYMM.sas7bdat'         => [550],
'mob_abon_base_cp_YYYYMM.sas7bdat'         => [550],
'srv_abon_base_m_YYYYMM.sas7bdat'         => [550],
'sub_abon_base_m_YYYYMM.sas7bdat'         => [550],
'tvh_abon_base_m_YYYYMM.sas7bdat'         => [550],
'watching_days_daily_YYYYMM.sas7bdat'         => [550],
'report_channel_owner_YYYYMM.sas7bdat'         => [550],
'sat_abon_base_activ_YYYYMM.sas7bdat'         => [550],
'sat_abon_base_activ_2_YYYYMM.sas7bdat'         => [550]
);