Virginia Clean Economy Project: Data Management Plan
================
Arthur Small
Version of 2020-03-31

This document describes the data management plan for the Virginia Clean
Economy project.

In this first iteration of the document the focus is on time series data
needed to populate the renewables dashboard.

-----

# The data

Many of the datasets we rely on will be *time series*. By definition,
time series report values of variables at regular time intervals, e.g.,
daily or annually. Examples include daily or annual total electricity
production in Virginia, in MWh.

Virginia’s clean energy goals or legislative mandates also generally
take the form of time series. These include mandated schedules for
renewable energy usage (a.k.a. Renewable Portfolio Standards), schedules
for carbon emissions reductions, and schedules for expenditures on
energy efficiency programs, among others.

We also will be working with other types of data that are not time
series. These include characteristics of generation assets: type, name
plate capacity, capacity factors, location, ownership, install date,
life expectancy, and so forth.

We anticipate that we will also be working with geospatial data to
generate maps. These may include shapefiles for specific geographic
areas.

We also will manage metadata in various forms and formats.

# Design principles

Our plan for managing time series data is guided by the following design
principles.

## Design principles for tables containing time series data

  - Data tables contain only date-time values and corresponding variable
    values.
      - All time-invariant characteristics of a series are stored in a
        separate table for metadata.
  - The first (i.e., left-most) column in the table reports date-time
    values.
      - For data with daily or lower frequency, this field is called
        `date`. Values in this field are stored using the postgres
        *date* type.
      - For hourly data, and for other series with frequency greater
        than once per day, this field is called `timestamptz`. Values in
        this field are stored using the postgres *timestamptz* type.
  - Each row in the table corresponds to a single block of time, e.g., a
    specific hour, or year.
  - Every record in the series corresponds to an (approximately)
    equally-sized unit of time, e.g., one hour, or one year.
  - A recorded date or time corresponds to the *start* of the
    corresponding time period.
      - For data with daily or lower frequency, the `date` field records
        the first date in the corresponding period. For example, monthly
        data for March 2020 are recorded with date `2020-03-01`.
      - For hourly data, and for other series with frequency greater
        than once per day, the `timestamptz` field records the start
        time of the corresponding period, in the UTC (a.k.a. GMT) time
        zone.\[1\]
  - A row is included for each sequential time step covering the entire
    period of record for the series.
      - Since date-time values are sequential, date-time fields cannot
        take `NULL` values.
  - Each column other than the date-time column contains values for a
    single variable.
      - All values in a given row correspond to a single time period.
      - Each cell contains at most one variable value.
      - Missing values are recorded with `NULL`’s.
  - For columns other than date-time, headers do not need to match
    “official” variable names exactly. Column headers serve merely as
    suggestive labels for the convenience of analysts perusing and
    extracting data in the database environment. “Official” variable
    names used in reports and visualizations are stored in the separate
    `metadata` table.
  - All variables reported in a single table should be closely related.
    Except as provided for explicitly and structurally, all variables in
    a table share the same metadata values. In particular, all values in
    a single table share a common unit of measure, e.g., MWh.
  - The date-time field serves as the primary key for tables containing
    time series data.

Applying these design principles, data tables for daily- and
lower-frequency time series will be structured as follows:

| Field                             | Description                      | Data type |
| --------------------------------- | -------------------------------- | --------- |
| `date`                            | Date for the start of the period | date      |
| `value_1` (or brief varible name) | Variable value                   | numeric   |
| `value_2` (or brief varible name) | Variable value                   | numeric   |
| `[...]`                           | \[More variable values\]         | numeric   |

Data tables for hourly- and other high-frequency time series will be
structured very similarly:

| Field                             | Description                                              | Data type   |
| --------------------------------- | -------------------------------------------------------- | ----------- |
| `timestamptz`                     | Date and time for the start of the period, UTC time zone | timestamptz |
| `value_1` (or brief varible name) | Variable value                                           | numeric     |
| `value_2` (or brief varible name) | Variable value                                           | numeric     |
| `[...]`                           | \[More variable values\]                                 | numeric     |

## Design principles for tables containing metadata for time series

  - Time-invariant characteristics of time series are stored in a
    separate metadata table, not in the data table itself.
  - The database includes a single metadata for time series datasets.
    This table is called \[at least provisionally\] `metadata`.
  - Each row in the `metadata` table corresponds to exactly one data
    series and, therefore, to exactly one data table.
  - Data tables are linked to their associated metadata via the
    `db_table_name` field in the `metadata` table.
      - The `db_table_name` field is the primary key for the `metadata`
        table.
      - The `db_table_name` field cannot take `NULL` values.
  - For time series, the `metadata` table is structured as displayed
    below:

| Field                      | Description                                                                              | Example value / Notes                                                                                                              |
| -------------------------- | ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `db_table_name`            | Name of the db table                                                                     | “elec\_sales\_va\_all\_m”                                                                                                          |
| `short_series_name`        | Series name for common use and display                                                   | “Total monthly generation”                                                                                                         |
| `full_series_name`         | Full/official name of the data series                                                    | “Net generation : all fuels : Virginia : all sectors : monthly”                                                                    |
| `column2variable_name_map` | List of ordered pairs in format “\[column\_names\_vector\], \[variable\_names\_vector\]” | ‘’c(“dom”, “appco”, “coops”), c(“Dominion”, “AppCo”, “Co-ops”)’’                                                                   |
| `units`                    | units of measure for variable value fields                                               | “MWh”                                                                                                                              |
| `frequency`                | Frequency of date-time steps                                                             | Allowable values: “A” or “Y” (annual/yearly), “Q” (quarterly), “M” (monthly), “W” (weekly), “D” (daily), “H” (hourly), “O” (other) |
| `data_source_brief_name`   | Brief name of the agency or entity that supplies the data                                | “EIA”                                                                                                                              |
| `data_source_full_name`    | Full name of the agency or entity that supplies the data                                 | “U.S. Energy Information Administration”                                                                                           |
| `url`                      | URL for the data source (if applicable)                                                  |                                                                                                                                    |
| `api`                      | If data are retrieved via an API: URL of the API                                         |                                                                                                                                    |
| `series_id`                | If data are retrieved via an API: series ID for the data series                          | “ELEC.SALES.VA-ALL.M”                                                                                                              |
| `json`                     | full JSON packet for the data series (if applicable)                                     |                                                                                                                                    |
| `notes`                    | Other notes or comments                                                                  | “Data received from DMME staff as Excel spreadsheet file funky\_data.xls”                                                          |

  - All fields in the `metadata` table have of the type *varchar*,
    execpt for the `frequency` field, which will be restricted to a
    single character.
  - All fields except for the `db_table_name` are `NULL`-able. However,
    leaving certain metadata fields unpopulated will be considered poor
    practice. The following practices and interpretations apply:
      - At least one of `short_series_name` or `full_series_name` fields
        should always be populated.
      - If the `units` field is `NULL`, variable values will be
        interpreted as unit-less pure numbers.
      - At least one of the `data_source_brief_name` or `data_source_full_name`
        fields should always be populated.
      - If the `api` field is populated, the `series_id` field should be
        also.
      - If `url` and `api` fields are both blank, an annotation should
        be entered manually in the `notes` column to explain the
        provenance of the data set.
  - The `column2variable_name_map` field links data columns to variable
    names. If these values are missing or incomplete, then no match can
    be made. In these cases, the name of the data table field (i.e., the
    column header) will be used as the default variable name:
      - If the `column2variable_name_map` field is empty (`NULL`), all
        the column names in the corresponding data table will be used as
        variable names.
      - If a specific data column name is not matched to any variable
        name via the listing in the `column2variable_name_map` field,
        that data column name will be used as the variable name.

## On names and name-matching

The rationale for maintaining this distinction between data table column
names and variable names may call for some discussion. Why create a
special `column2variable_name_map` field? Why not simply use the column
names as the variable names, and *vice versa*? What are the benefits of
this added complexity?

In this framework, the names of data series and specific variables are
treated as *data*: they are not hard-coded as the names of database
tables or database columns. Instead, the `metadata` table includes
information that links the names of database objects to the
corresponding names used in reports and visualizations.

There are several motivations for maintaining this separation of
database objects from the names used in reporting.

First, postgres naming conventions impose restrictions on allowable
names that are not consistent with the needs of reporting. Postgres
*tables* must use only lower-case alphanumeric characters and the
underscore character; they must contain no spaces. A common name like
“Total generation” would not be allowed.

Postgres *fields* can in principle contain more types of characters,
including spaces. However, when a column name includes characters from
this extended character set, it is generally necessary to enclose the
column name inside quotes ("") when referring to it in an SQL query.
This requirement imposes burdens and creates clutter when writing
queries. It is preferable to assign names to database objects that
follow standard SQL and PostgreSQL conventions.

A second reason for separating reporting names from database object
names is that different data sources may use different names for what
are, in fact, the same underlying concept. The
`column2variable_name_map` field provides a simple and robust mechanism
for mapping the naming schemes from multiple data providers to a single,
common set of concept meanings.\[2\]

A third reason concerns ease of code maintenance. If for some reason we
wish to change the way a variable name is reported or represented in
visualizations, we don’t want to have to edit the hard-coded names of
multiple database objects. Instead, we wish to change the variable names
in one or at most a few entries in the `metadata` table, and have those
changes propogate through to all reporting outputs.

## Special handling of time series forecasts

Forecasts are a special form of time series. Time series of forecasts
should report: the time period for which the forecast is made, the
forecast value, the time when the forecast is issued, and information
about the corresponding series of observations, i.e. what variable is
being forecast.

Tables of forecasts will be structured in the same way as the tables for
corresponding historical observations, except that an additional field
will be added to give the date-time at which the forecast was
issued.\[3\]

Forecasts of daily or lower-frequency time series will, therefore, be
structured as follows:

| Field                             | Description                                               | Data type |
| --------------------------------- | --------------------------------------------------------- | --------- |
| `forecast_issue_date`             | Date on which forecast is generated                       | date      |
| `forecast_for_date`               | Date of the start of the period to which forecast applies | date      |
| `value_1` (or brief varible name) | Variable value                                            | numeric   |
| `value_2` (or brief varible name) | Variable value                                            | numeric   |
| `[...]`                           | \[More variable values\]                                  | numeric   |

Forecasts of higher-frequency, e.g., hourly timeseries will be
structured similarly:

| Field                             | Description                                                        | Data type   |
| --------------------------------- | ------------------------------------------------------------------ | ----------- |
| `forecast_issue_timestamptz`      | Date and time at which forecast is generated                       | timestamptz |
| `forecast_for_timestamptz`        | Date and time of the start of the period to which forecast applies | timestamptz |
| `value_1` (or brief varible name) | Variable value                                                     | numeric     |
| `value_2` (or brief varible name) | Variable value                                                     | numeric     |
| `[...]`                           | \[More variable values\]                                           | numeric     |

Metadata for forecast series are augmented to include the name of the
data table containing the historical values of the variables being
forecast. This is accomplished most by adding two fields to the time
series `metadata` table: a Boolean indicator variable `is_a_forecast`,
and a *varchar* field `db_table_with_obs` with the name of the database
table containing values of corresponding historical observation
variables. For these two fields the following conventions and practices
apply:

  - An `is_a_forecast` value of `TRUE` or `1` indicates that the
    associated table contains forecasts of another time series variable.
    An `is_a_forecast` value of `FALSE`, `0` or `NULL` indicates that
    the associated table does not contain forecasts. The default value
    for the `is_a_forecast` field is `NULL`.
  - If the `is_a_forecast` field has a value of `TRUE` or `1`, the
    `db_table_with_obs` must be populated with the name of a (different)
    data table containing historical observation data. If the
    `is_a_forecast` field takes a value of `FALSE`, `0` or `NULL`, the
    `db_table_with_obs` should take a `NULL` value.
  - *Matching variable names between forecasts and corresponding
    observations:* If one data table includes forecasts of variables for
    which historical observations are reported in a second table, the
    names of data columns should match exactly. If there are multiple
    columns with data values (i.e., if the forecast is multivariate),
    each forecast column name should match exactly the name of the
    corresponding column with historical observation data. This matching
    should be reinforced by keeping identical entries in the
    `column2variable_name_map` fields for both the forecast and
    observation series.

# Database tables: Creating, updating, and deleting

# Specific types of data

## Generation assets

Generation assets are identified with multiple characteristics: type,
name plate capacity, capacity factors, location, ownership, install
date, life expectancy, and so forth.

## State mandates and goals

# Naming conventions

There is value in adopting standardized conventions for assigning names
to data variables and other database elements.

As a starting point, we adopt the naming conventions established by the
U.S. Energy Information Agency.

ISO naming conventions will be used when available and appropriate.

-----

1.  For hourly and other high-frequency data, standardizing the time
    zone to UTC avoids the annoyance of needing to manage the
    twice-a-year shift of time stamps at the beginning and end of
    Daylight Savings Time.

2.  Values in the `column2variable_name_map` fields can, therefore, be
    seen as part of the data for a simple
    [ontology](https://en.wikipedia.org/wiki/Ontology_\(information_science\))
    for the clean energy and economy domain.

3.  This discussion assumes that forecasts are deterministic. We do not
    at present plan to store *probabilistic* forecasts in the database.
    If a need to do so arises, we will create appropriate data
    structures at that time.
