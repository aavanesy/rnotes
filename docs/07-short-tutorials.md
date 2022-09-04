# Short tutorials in R

## Parsing HTML Tables from static websites


```r
library(dplyr)
library(htmltab)

url = 'https://www.slickcharts.com/dowjones'

table = htmltab(url, which = 1) %>% 
  dplyr::select(Company, Symbol, Weight)

table %>% 
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
   <td style="text-align:left;"> 10.904609 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Goldman Sachs Group Inc. </td>
   <td style="text-align:left;"> GS </td>
   <td style="text-align:left;"> 6.940242 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Home Depot Inc. </td>
   <td style="text-align:left;"> HD </td>
   <td style="text-align:left;"> 6.105124 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Microsoft Corporation </td>
   <td style="text-align:left;"> MSFT </td>
   <td style="text-align:left;"> 5.419008 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> McDonald's Corporation </td>
   <td style="text-align:left;"> MCD </td>
   <td style="text-align:left;"> 5.337224 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Amgen Inc. </td>
   <td style="text-align:left;"> AMGN </td>
   <td style="text-align:left;"> 5.108934 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Visa Inc. Class A </td>
   <td style="text-align:left;"> V </td>
   <td style="text-align:left;"> 4.16477 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Honeywell International Inc. </td>
   <td style="text-align:left;"> HON </td>
   <td style="text-align:left;"> 3.969153 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Caterpillar Inc. </td>
   <td style="text-align:left;"> CAT </td>
   <td style="text-align:left;"> 3.796635 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Johnson &amp; Johnson </td>
   <td style="text-align:left;"> JNJ </td>
   <td style="text-align:left;"> 3.440779 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Travelers Companies Inc. </td>
   <td style="text-align:left;"> TRV </td>
   <td style="text-align:left;"> 3.398326 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Apple Inc. </td>
   <td style="text-align:left;"> AAPL </td>
   <td style="text-align:left;"> 3.287199 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Chevron Corporation </td>
   <td style="text-align:left;"> CVX </td>
   <td style="text-align:left;"> 3.236837 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Boeing Company </td>
   <td style="text-align:left;"> BA </td>
   <td style="text-align:left;"> 3.197714 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Salesforce Inc. </td>
   <td style="text-align:left;"> CRM </td>
   <td style="text-align:left;"> 3.195009 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> American Express Company </td>
   <td style="text-align:left;"> AXP </td>
   <td style="text-align:left;"> 3.144648 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Procter &amp; Gamble Company </td>
   <td style="text-align:left;"> PG </td>
   <td style="text-align:left;"> 2.905953 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Walmart Inc. </td>
   <td style="text-align:left;"> WMT </td>
   <td style="text-align:left;"> 2.798572 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> International Business Machines Corporation </td>
   <td style="text-align:left;"> IBM </td>
   <td style="text-align:left;"> 2.698266 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3M Company </td>
   <td style="text-align:left;"> MMM </td>
   <td style="text-align:left;"> 2.614401 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> JPMorgan Chase &amp; Co. </td>
   <td style="text-align:left;"> JPM </td>
   <td style="text-align:left;"> 2.38299 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Walt Disney Company </td>
   <td style="text-align:left;"> DIS </td>
   <td style="text-align:left;"> 2.341785 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NIKE Inc. Class B </td>
   <td style="text-align:left;"> NKE </td>
   <td style="text-align:left;"> 2.216091 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Merck &amp; Co. Inc. </td>
   <td style="text-align:left;"> MRK </td>
   <td style="text-align:left;"> 1.81362 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Coca-Cola Company </td>
   <td style="text-align:left;"> KO </td>
   <td style="text-align:left;"> 1.29024 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Dow Inc. </td>
   <td style="text-align:left;"> DOW </td>
   <td style="text-align:left;"> 1.039689 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Cisco Systems Inc. </td>
   <td style="text-align:left;"> CSCO </td>
   <td style="text-align:left;"> 0.942499 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Verizon Communications Inc. </td>
   <td style="text-align:left;"> VZ </td>
   <td style="text-align:left;"> 0.87008 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Walgreens Boots Alliance Inc. </td>
   <td style="text-align:left;"> WBA </td>
   <td style="text-align:left;"> 0.733772 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Intel Corporation </td>
   <td style="text-align:left;"> INTC </td>
   <td style="text-align:left;"> 0.660936 </td>
  </tr>
</tbody>
</table>

