#!/bin/bash
@echo off
echo ----------------------------------------------------------------------
echo -----------------------------api_data_code----------------------------
echo ----------------------------------------------------------------------
echo -------------------------fetch_from_eia_api.R-------------------------
Rscript api_data_code/fetch_from_eia_api.R
echo ----------------------------------------------------------------------
echo -------------------------fetch_from_FRED_api.R------------------------
Rscript api_data_code/fetch_from_FRED_api.R
echo ----------------------------------------------------------------------
echo ------------------------generation_all_states.R-----------------------
Rscript api_data_code/generation_all_states.R
echo ----------------------------------------------------------------------
echo ---------------------------fetch_from_EPA.R---------------------------
Rscript api_data_code/fetch_from_EPA.R
echo ----------------------------------------------------------------------
echo -------------------cleaning_and_uploading_data_code-------------------
echo ----------------------------------------------------------------------
echo ------------------cleaning_annual_capacity_factors.R------------------
Rscript cleaning_and_uploading_data_code/cleaning_annual_capacity_factors.R
echo ----------------------------------------------------------------------
echo -------------------------cleaning_capacity.R--------------------------
Rscript cleaning_and_uploading_data_code/cleaning_capacity.R
echo ----------------------------------------------------------------------
echo ----------------------cleaning_capacity_monthly.R---------------------
Rscript cleaning_and_uploading_data_code/cleaning_capacity_monthly.R
echo ----------------------------------------------------------------------
echo -------------cleaning_city_consumption_expenditures_2016.R------------
Rscript cleaning_and_uploading_data_code/cleaning_city_consumption_expenditures_2016.R
echo ----------------------------------------------------------------------
echo ------------cleaning_county_consumption_expenditure_2016.R------------
Rscript cleaning_and_uploading_data_code/cleaning_county_consumption_expenditure_2016.R
echo ----------------------------------------------------------------------
echo ------------------------cleaning_deep_solar.R-------------------------
Rscript cleaning_and_uploading_data_code/cleaning_deep_solar.R
echo ----------------------------------------------------------------------
echo ---------------cleaning_dominion_efficiency_programs.R----------------
Rscript cleaning_and_uploading_data_code/cleaning_dominion_efficiency_programs.R
echo ----------------------------------------------------------------------
echo ---------------------------cleaning_eia860.R--------------------------
Rscript cleaning_and_uploading_data_code/cleaning_eia860.R
echo ----------------------------------------------------------------------
echo ------------------cleaning_elec_sales_through_2019.R------------------
Rscript cleaning_and_uploading_data_code/cleaning_elec_sales_through_2019.R
echo ----------------------------------------------------------------------
echo --------------------cleaning_electricity_summary.R--------------------
Rscript cleaning_and_uploading_data_code/cleaning_electricity_summary.R
echo ----------------------------------------------------------------------
echo -------------------------cleaning_emissions.R-------------------------
Rscript cleaning_and_uploading_data_code/cleaning_emissions.R
echo ----------------------------------------------------------------------
echo ---------------------cleaning_energy_burden_va.R----------------------
Rscript cleaning_and_uploading_data_code/cleaning_energy_burden_va.R
echo ----------------------------------------------------------------------
echo ----------------cleaning_energy_efficiency_programs.R-----------------
Rscript cleaning_and_uploading_data_code/cleaning_energy_efficiency_programs.R
echo ----------------------------------------------------------------------
echo ----------------------cleaning_energy_savings.R-----------------------
Rscript cleaning_and_uploading_data_code/cleaning_energy_savings.R
echo ----------------------------------------------------------------------
echo ---------------------------cleaning_fuel.R----------------------------
Rscript cleaning_and_uploading_data_code/cleaning_fuel.R
echo ----------------------------------------------------------------------
echo -------------------cleaning_generation_by_sector.R--------------------
Rscript cleaning_and_uploading_data_code/cleaning_generation_by_sector.R
echo ----------------------------------------------------------------------
echo ------------------------cleaning_net_metering.R-----------------------
Rscript cleaning_and_uploading_data_code/cleaning_net_metering.R
echo ----------------------------------------------------------------------
echo -----------------------cleaning_offshore_wind.R-----------------------
Rscript cleaning_and_uploading_data_code/cleaning_offshore_wind.R
echo ----------------------------------------------------------------------
echo -------------------------cleaning_ownership.R-------------------------
Rscript cleaning_and_uploading_data_code/cleaning_ownership.R
echo ----------------------------------------------------------------------
echo ----------------------------cleaning_pjm.R----------------------------
Rscript cleaning_and_uploading_data_code/cleaning_pjm.R
echo ---------------------------------------------------------------------
echo --------------------------cleaning_plants.R---------------------------
Rscript cleaning_and_uploading_data_code/cleaning_plants.R
echo ----------------------------------------------------------------------
echo -------------------------cleaning_retailers.R-------------------------
Rscript cleaning_and_uploading_data_code/cleaning_retailers.R
echo ----------------------------------------------------------------------
echo ------------------cleaning_rooftop_solar_low_income.R-----------------
Rscript cleaning_and_uploading_data_code/cleaning_rooftop_solar_low_income.R
echo ----------------------------------------------------------------------
echo ---------------------cleaning_total_expenditure.R---------------------
Rscript cleaning_and_uploading_data_code/cleaning_total_expenditure.R
echo ----------------------------------------------------------------------
echo -------------------cleaning_utility_scale_storage.R-------------------
Rscript cleaning_and_uploading_data_code/cleaning_utility_scale_storage.R
echo ----------------------------------------------------------------------
echo -------------------------cleaning_VCEA_goals.R------------------------
Rscript cleaning_and_uploading_data_code/cleaning_VCEA_goals.R
echo ----------------------------------------------------------------------
echo ------------------cleaning_virginia_annual_savings.R------------------
Rscript cleaning_and_uploading_data_code/cleaning_virginia_annual_savings.R
echo ----------------------------------------------------------------------
echo -------------------deriving_and_uploading_data_code-------------------
echo ----------------------------------------------------------------------
echo -----------------------deriving_co2_emissions.R-----------------------
Rscript deriving_and_uploading_data_code/deriving_co2_emissions.R
echo ----------------------------------------------------------------------
echo --------------------deriving_energy_consumption.R---------------------
Rscript deriving_and_uploading_data_code/deriving_energy_consumption.R
echo ----------------------------------------------------------------------
echo -------------------------------metadata-------------------------------
echo ----------------------------------------------------------------------
echo ------------------------------metadata.R------------------------------
Rscript metadata/metadata.R
echo ----------------------------------------------------------------------
echo -----------------------metadata_code_capacity.R-----------------------
Rscript metadata/metadata_code_capacity.R
echo ----------------------------------------------------------------------
echo -------------------metadata_code_capacity_factors.R-------------------
Rscript metadata/metadata_code_capacity_factors.R
echo ----------------------------------------------------------------------
echo --------------------metadata_code_co2_emissions.R---------------------
Rscript metadata/metadata_code_co2_emissions.R
echo ----------------------------------------------------------------------
echo ------------------metadata_code_current_ee_programs.R-----------------
Rscript metadata/metadata_code_current_ee_programs.R
echo ----------------------------------------------------------------------
echo ----------------------metadata_code_deep_solar.R----------------------
Rscript metadata/metadata_code_deep_solar.R
echo ----------------------------------------------------------------------
echo --------------metadata_code_dominion_efficiency_programs.R--------------
Rscript metadata/metadata_code_dominion_efficiency_programs.R
echo ----------------------------------------------------------------------
echo ------------------------metadata_code_eia860.R------------------------
Rscript metadata/metadata_code_eia860.R
echo ----------------------------------------------------------------------
echo ------------------metadata_code_electricity_summary.R-----------------
Rscript metadata/metadata_code_electricity_summary.R
echo ----------------------------------------------------------------------
echo -----------------------metadata_code_emissions.R----------------------
Rscript metadata/metadata_code_emissions.R
echo ----------------------------------------------------------------------
echo ---------------------metadata_code_energy_burden.R--------------------
Rscript metadata/metadata_code_energy_burden.R
echo ----------------------------------------------------------------------
echo ------------------metadata_code_energy_consumption.R------------------
Rscript metadata/metadata_code_energy_consumption.R
echo ----------------------------------------------------------------------
echo ------------------metadata_code_energy_savings.R----------------------
Rscript metadata/metadata_code_energy_savings.R
echo ----------------------------------------------------------------------
echo -----------------------metadata_code_FRED_data.R----------------------
Rscript metadata/metadata_code_FRED_data.R
echo ----------------------------------------------------------------------
echo -------------------------metadata_code_fuel.R-------------------------
Rscript metadata/metadata_code_fuel.R
echo ----------------------------------------------------------------------
echo ---------------------metadata_code_gen_by_state.R---------------------
Rscript metadata/metadata_code_gen_by_state.R
echo ----------------------------------------------------------------------
echo ----------------------metadata_code_generation.R----------------------
Rscript metadata/metadata_code_generation.R
echo ----------------------------------------------------------------------
echo ---------------------metadata_code_net_metering.R---------------------
Rscript metadata/metadata_code_net_metering.R
echo ----------------------------------------------------------------------
echo --------------------metadata_code_offshore_wind.R---------------------
Rscript metadata/metadata_code_offshore_wind.R
echo ----------------------------------------------------------------------
echo -----------------------metadata_code_ownership.R----------------------
Rscript metadata/metadata_code_ownership.R
echo ----------------------------------------------------------------------
echo --------------------------metadata_code_pjm.R-------------------------
Rscript metadata/metadata_code_pjm.R
echo ----------------------------------------------------------------------
echo --------------metadata_code_plant_generation_capacity.R---------------
Rscript metadata/metadata_code_plant_generation_capacity.R
echo ----------------------------------------------------------------------
echo -----------------------metadata_code_retailers.R----------------------
Rscript metadata/metadata_code_retailers.R
echo ----------------------------------------------------------------------
echo ---------------metadata_code_rooftop_solar_low_income.R---------------
Rscript metadata/metadata_code_rooftop_solar_low_income.R
echo ----------------------------------------------------------------------
echo -------------------metadata_code_total_expenditure.R------------------
Rscript metadata/metadata_code_total_expenditure.R
echo ----------------------------------------------------------------------
echo -------------------metadata_code_VA_annual_savings.R------------------
Rscript metadata/metadata_code_VA_annual_savings.R
echo ----------------------------------------------------------------------
echo ----------------------metadata_code_VCEA_goals.R----------------------
Rscript metadata/metadata_code_VCEA_goals.R
echo ----------------------------------------------------------------------
