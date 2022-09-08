# Short tutorials in R

## Parsing HTML Tables from static websites


```r
library(dplyr)
library(htmltab)

url = 'https://www.slickcharts.com/dowjones'

table = htmltab(url, which = 1) %>% 
  dplyr::select(Company, Symbol, Weight)

table %>% 
  head() %>% 
  kableExtra::kbl(row.names = F) %>% 
  kableExtra::kable_styling(full_width = F, position = 'left') %>% 
  kableExtra::kable_styling(font_size = 11) %>% 
  kableExtra::kable_styling(bootstrap_options = c("hover", "condensed")) 
```

<table class="table table table table-hover table-condensed" style="width: auto !important;  font-size: 11px; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Company </th>
   <th style="text-align:left;"> Symbol </th>
   <th style="text-align:left;"> Weight </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> UnitedHealth Group Incorporated </td>
   <td style="text-align:left;"> UNH </td>
   <td style="text-align:left;"> 10.949809 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Goldman Sachs Group Inc. </td>
   <td style="text-align:left;"> GS </td>
   <td style="text-align:left;"> 6.905817 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Home Depot Inc. </td>
   <td style="text-align:left;"> HD </td>
   <td style="text-align:left;"> 6.124262 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> McDonald's Corporation </td>
   <td style="text-align:left;"> MCD </td>
   <td style="text-align:left;"> 5.380779 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Microsoft Corporation </td>
   <td style="text-align:left;"> MSFT </td>
   <td style="text-align:left;"> 5.356667 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Amgen Inc. </td>
   <td style="text-align:left;"> AMGN </td>
   <td style="text-align:left;"> 5.123363 </td>
  </tr>
</tbody>
</table>


## Encrypt Data in R

Saving encrypted user data on SQL or in Rdata files with sensitive information is easy with the sodium package. 

With the script below your passwords are encrypted and are no longer available as such.


```r
library(sodium)
# userbase
users <- tibble(Username = c('Al', 'Ben', 'Carl'),
                Password = c('hello', '123456', 'cocacola'))

# Encrypt passwords
users_enc <- users %>% 
  rowwise() %>% 
  mutate(Password = sodium::password_store(Password))

users_enc
#> # A tibble: 3 x 2
#> # Rowwise: 
#>   Username Password                                         
#>   <chr>    <chr>                                            
#> 1 Al       $7$C6..../....ispLZcCfQZYXu5MFAkMp2wlqpvIC6mwqPA~
#> 2 Ben      $7$C6..../....Xpa5jMz8iFjjgSo0eY8akKM9NjM8zJT8qH~
#> 3 Carl     $7$C6..../....O5OMro.2nuZOAexvoEDoe4Lfh85Oy3W2OJ~

# save as Rdata if necessary, ideally store in SQL database
# save(users_enc, file = 'userbase.Rdata')

# verify if correct
sodium::password_verify(users_enc$Password[1], 'Hello')
#> [1] FALSE
sodium::password_verify(users_enc$Password[2], '123456')
#> [1] TRUE
```

