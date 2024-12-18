## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = TRUE
)

## ----setup--------------------------------------------------------------------
library(datimutils)
library(httptest)
library(magrittr)

## ---- include = FALSE---------------------------------------------------------
library(httptest)
httptest::start_vignette("Introduction-to-datimutils")

## ----eval = T-----------------------------------------------------------------
loginToDATIM(
  base_url = "https://play.im.dhis2.org/dev/",
  username = "admin",
  password = "district"
)

## -----------------------------------------------------------------------------
list.files(system.file("shiny-examples", "OAuth", package = "datimutils"))

## -----------------------------------------------------------------------------
data <- tibble::tribble(~dataElement, ~orgUnit, ~value,
                "fbfJHSPpUQD", "kJq2mPyFEHo", 1,
                "cYeuwXTCPkU", "kJq2mPyFEHo", 2,
                "fbfJHSPpUQD", "Vth0fbpFcsO", 3
                )
print(data)

## ----table1, echo=FALSE, message=FALSE, warnings=FALSE, results='asis'--------
tabl <- "
|                       datimutils function                      | DATIM Source               |
|----------------------------------------------------------------|:--------------------------:|
| getCategories           | categories                 |
| getCatCombos            | categoryCombinations       |
| getCatOptionCombos      | categoryOptionCombinations |
| getCatOptionGroupSets   | categoryOptionGroupSets    |
| getCatOptionGroups      | categoryOptionGroups       |
| getCatOptions           | categoryOptions            |
| getDataElementGroupSets | dataElementGroupSets       |
| getDataElementGroups    | dataElementGroups          |
| getDataElements         | dataElements               |
| getDataSets             | dataSets                   |
| getIndicatorGroupSets   | indicatorGroupSets         |
| getIndicatorGroups      | indicatorGroups            |
| getIndicators           | indicators                 |
| getOptionGroupSets      | optionGroupSets            |
| getOptionGroups         | optionGroups               |
| getOptionSets           | optionSets                 |
| getOptions              | options                    |
| getOrgUnitGroupSets     | organisationUnitGroupSets  |
| getOrgUnitGroups        | organisationUnitGroups     |
| getOrgUnits             | organisationUnits          |
| getDimensions           | dimensions                 |
| getUserGroups           | userGroups                 |
"
cat(tabl)

## -----------------------------------------------------------------------------
getOrgUnits(data$orgUnit)

## -----------------------------------------------------------------------------
dplyr::mutate(data,
              dataElementName = datimutils::getDataElements(dataElement))


## -----------------------------------------------------------------------------
url <- paste0("https://play.im.dhis2.org/dev/api/organisationUnits.json?paging=false&filter=id:in:[kJq2mPyFEHo,Vth0fbpFcsO]&fields=id,nameapi/dataElements.json?",
"filter=id:in:[fbfJHSPpUQD,cYeuwXTCPkU,fbfJHSPpUQD]",
"&fields=name")

httr::GET(url,
          httr::authenticate("admin",
                             "district")) %>%
  httr::content(as = "text") %>%
  jsonlite::fromJSON(simplifyDataFrame = TRUE,  
                     flatten = TRUE) %>%
  print()

## -----------------------------------------------------------------------------
getOrgUnits("Bo",
            by = name)


## -----------------------------------------------------------------------------
getDataElements("DE_359596",
                by = code)


## -----------------------------------------------------------------------------
data <- getMetadata(
  end_point = "organisationUnits",
  "organisationUnitGroups.name:eq:District",
  fields = "id,name,level"
)

head(data)

## -----------------------------------------------------------------------------
data <- getMetadata(
  end_point = "organisationUnits",
  organisationUnitGroups.name %.eq% "District",
  fields = "id,name,level"
)

head(data)

## -----------------------------------------------------------------------------
data <- getMetadata(
  end_point = organisationUnits,
  organisationUnitGroups.name %.eq% "District",
  fields = "id,name,level"
)

head(data)

## -----------------------------------------------------------------------------
# returns a vector
data <- getMetadata(
  end_point = "organisationUnitGroups",
  fields = "name"
)
print(data)

## -----------------------------------------------------------------------------
data <- getMetadata(
  end_point = "organisationUnits",
  "name:like:Baoma",
  "level:eq:3",
  fields = ":all"
)
str(data$translations)

## -----------------------------------------------------------------------------
data <- getMetadata(organisationUnits,
                    "name:like:Baoma",
                    "level:eq:3",
                    fields = ":all"
)
str(data$translations)

## -----------------------------------------------------------------------------
data <- getMetadata(organisationUnits,
                    name %.Like%  "Baoma",
                    level %.eq% 3,
                    fields = ":all"
)
str(data$translations)

## ----table2, echo=FALSE, message=FALSE, warnings=FALSE, results='asis'--------
tabl <- "
| DHIS2 Operator| infix operator  | Description                                     |
|---------------|:---------------:|------------------------------------------------:|
| eq            | %.eq%           | Equality                                        |
| !eq           | %.~eq%          | Inequality                                      |
| like          | %.Like%         | Case sensitive string, match anywhere           |
| !like         | %.~Like%        | Case sensitive string, not match anywhere       |
| \\$like       | %.^Like%       | Case sensitive string, match start             |
| !\\$like      | %.~^Like%      | Case sensitive string, not match start         |
| like\\$       | %.Like$%       | Case sensitive string, match end               |
| !like\\$      | %.~Like$%      | Case sensitive string, not match end           |
| ilike         | %.like%         | Case insensitive string, match anywhere         |
| !ilike        | %.~like%        | Case insensitive string, not match anywhere     |
| \\$ilike      | %.^like%       | Case insensitive string, match start           |
| !\\$ilike     | %.~^like%      | Case insensitive string, not match start       |
| ilike\\$      | %.like$%       | Case insensitive string, match end             |
| !ilike\\$     | %.~like$%      | Case insensitive string, not match end         |
| gt            | %.gt%           | Greater than                                    |
| ge            | %.ge%           | Greater than or equal                           |
| lt            | %.lt%           | Less than                                       |
| le            | %.le%           | Less than or equal                              |
| token         | %.token%        | Match on multiple tokens in search property     |
| !token        | %.~token%       | Not match on multiple tokens in search property |
| in            | %.in%           | Find objects matching 1 or more values          |
| !in           | %.~in%          | Find objects not matching 1 or more values      |
"
cat(tabl)

## -----------------------------------------------------------------------------
#Get ANC: Key Coverages
#this call uses only dimension arguments, dx, ou, and pe
data <- datimutils::getAnalytics(dx = "Uvn6LCg7dVU",
                                 ou = "O6uvpzGd5pu",
                                 pe = "LAST_12_MONTHS",
                                 return_names = TRUE)

head(data)

## -----------------------------------------------------------------------------
datimutils::getAnalytics(dx = "Uvn6LCg7dVU",
                         ou = c("O6uvpzGd5pu", "fdc6uOvgoji"),
                         pe = "LAST_12_MONTHS",
                         return_names = TRUE)

datimutils::getAnalytics(dx = "Uvn6LCg7dVU",
                         ou_f = c("O6uvpzGd5pu", "fdc6uOvgoji"),
                         pe = "LAST_12_MONTHS",
                         return_names = TRUE)


## ---- include = FALSE---------------------------------------------------------
httptest::end_vignette()

