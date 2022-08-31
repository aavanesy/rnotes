# R and Python Challenges

## Pulling data from Yahoo Finance and handling errors

### Original text on Linkedin

<https://www.linkedin.com/posts/activity-6969997960340193280-4vbp?utm_source=share&utm_medium=member_desktop>

This is a mini-project I worked on last week and got paid. First, I drafted a base R solution and in the second iteration a more robust solution with functional programming.

My final solution is six steps with piping. Curious to see python versions as well.

We have a list of hundreds of yahoo finance tickers. Some of them are inactive.

To simplify, let's take only 6. The ticker A1B1 is invalid.

tickers \<- c("MMM", "ABBV", "ABMD", "A1B1", \# invalid ticker "ACN", "ADM")

We use the function getSymbols from quantmod to extract the values. It will run into an error if we run an invalid ticker.

quantmod::getSymbols("MMM", from = "2010-12-31", to = "2022-01-01", env = NULL, auto.assign = FALSE)

It returns the Open, High, Low, Close, Volume, and Adjusted Price. All we need is the last column, Adjusted.

Finally, all results must be aggregated into a single tibble object, as per the screenshot (shows the first and last five rows, 2770 in total).

### Solution using functional programming in R

Invalid ticker A1B1 will cause an error: we use **possibly** from purrr which will return NULL when getSymbols will fail.\
Different tickers will have different inception dates. I use merge.xts from the package xts as it will by default perform an outer join and add all possible dates.\
Example: ticker A exists since 2015, ticker B since 2010. The left join from dplyr will omit five years of data.\
The dplyr alternative is the full join but as quantmod returns an xts object by definition, I opt for merge.xts.


```r
suppressWarnings(suppressMessages(library(dplyr)));
suppressWarnings(suppressMessages(library(purrr)));
suppressWarnings(suppressMessages(library(tidyquant)));

tickers <- c("MMM", "ABBV", "ABMD",
            "A1B1", #invalid ticker
            "ACN", "ADM")


res = tickers %>% 
  map(possibly(.f = ~ quantmod::getSymbols(.x, from = "2010-12-31",
                                 to = "2022-01-01",
                                 env = NULL,
                                 auto.assign = FALSE)[,6],
               otherwise = NULL)) %>% 
  #from purrr, removing the NULL objects from a list
  discard(is.null) %>% 
  #from purrr, merging elements of a list using a specific function
  reduce(merge.xts) %>% 
  #converting the xts result to data.frame
  as.data.frame() %>% 
  #add Date as the first column
  mutate(Date = rownames(.) %>% as.Date(), .before = everything()) 
#> Warning: A1B1 download failed; trying again.
```

<table class="table table table table-hover table-condensed" style="width: auto !important;  font-size: 11px; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> Date </th>
   <th style="text-align:right;"> MMM.Adjusted </th>
   <th style="text-align:right;"> ABBV.Adjusted </th>
   <th style="text-align:right;"> ABMD.Adjusted </th>
   <th style="text-align:right;"> ACN.Adjusted </th>
   <th style="text-align:right;"> ADM.Adjusted </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2010-12-31 </td>
   <td style="text-align:left;"> 2010-12-31 </td>
   <td style="text-align:right;"> 61.97549 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9.61 </td>
   <td style="text-align:right;"> 38.88908 </td>
   <td style="text-align:right;"> 22.06220 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2011-01-03 </td>
   <td style="text-align:left;"> 2011-01-03 </td>
   <td style="text-align:right;"> 62.32738 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9.80 </td>
   <td style="text-align:right;"> 38.96928 </td>
   <td style="text-align:right;"> 22.29691 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2011-01-04 </td>
   <td style="text-align:left;"> 2011-01-04 </td>
   <td style="text-align:right;"> 62.24119 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9.80 </td>
   <td style="text-align:right;"> 38.71263 </td>
   <td style="text-align:right;"> 22.28224 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2011-01-05 </td>
   <td style="text-align:left;"> 2011-01-05 </td>
   <td style="text-align:right;"> 62.24119 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 10.03 </td>
   <td style="text-align:right;"> 38.72066 </td>
   <td style="text-align:right;"> 22.38493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2011-01-06 </td>
   <td style="text-align:left;"> 2011-01-06 </td>
   <td style="text-align:right;"> 61.86057 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 10.05 </td>
   <td style="text-align:right;"> 38.86502 </td>
   <td style="text-align:right;"> 23.24305 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2011-01-07 </td>
   <td style="text-align:left;"> 2011-01-07 </td>
   <td style="text-align:right;"> 61.92524 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9.89 </td>
   <td style="text-align:right;"> 38.92918 </td>
   <td style="text-align:right;"> 23.43376 </td>
  </tr>
</tbody>
</table>

<table class="table table table table-hover table-condensed" style="width: auto !important;  font-size: 11px; margin-left: auto; margin-right: auto; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> Date </th>
   <th style="text-align:right;"> MMM.Adjusted </th>
   <th style="text-align:right;"> ABBV.Adjusted </th>
   <th style="text-align:right;"> ABMD.Adjusted </th>
   <th style="text-align:right;"> ACN.Adjusted </th>
   <th style="text-align:right;"> ADM.Adjusted </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2021-12-23 </td>
   <td style="text-align:left;"> 2021-12-23 </td>
   <td style="text-align:right;"> 169.8183 </td>
   <td style="text-align:right;"> 129.4026 </td>
   <td style="text-align:right;"> 352.21 </td>
   <td style="text-align:right;"> 399.6512 </td>
   <td style="text-align:right;"> 64.49468 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2021-12-27 </td>
   <td style="text-align:left;"> 2021-12-27 </td>
   <td style="text-align:right;"> 171.4974 </td>
   <td style="text-align:right;"> 130.6860 </td>
   <td style="text-align:right;"> 357.83 </td>
   <td style="text-align:right;"> 411.5622 </td>
   <td style="text-align:right;"> 65.11557 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2021-12-28 </td>
   <td style="text-align:left;"> 2021-12-28 </td>
   <td style="text-align:right;"> 172.4097 </td>
   <td style="text-align:right;"> 130.6666 </td>
   <td style="text-align:right;"> 357.44 </td>
   <td style="text-align:right;"> 411.5028 </td>
   <td style="text-align:right;"> 65.96315 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2021-12-29 </td>
   <td style="text-align:left;"> 2021-12-29 </td>
   <td style="text-align:right;"> 173.1571 </td>
   <td style="text-align:right;"> 131.6097 </td>
   <td style="text-align:right;"> 361.84 </td>
   <td style="text-align:right;"> 411.6514 </td>
   <td style="text-align:right;"> 66.04199 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2021-12-30 </td>
   <td style="text-align:left;"> 2021-12-30 </td>
   <td style="text-align:right;"> 172.4097 </td>
   <td style="text-align:right;"> 132.1639 </td>
   <td style="text-align:right;"> 362.06 </td>
   <td style="text-align:right;"> 410.0758 </td>
   <td style="text-align:right;"> 65.89417 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2021-12-31 </td>
   <td style="text-align:left;"> 2021-12-31 </td>
   <td style="text-align:right;"> 172.4000 </td>
   <td style="text-align:right;"> 131.6486 </td>
   <td style="text-align:right;"> 359.17 </td>
   <td style="text-align:right;"> 410.7893 </td>
   <td style="text-align:right;"> 66.61361 </td>
  </tr>
</tbody>
</table>

### Python Solution by Georgi Petkov


```python
import yahoo_fin.stock_info as si
import pandas as pd

tickers = ["MMM", "ABBV", "ABMD","A1B1","ACN", "ADM"]

ticker_series = [] # store extracted data

missing_ticker =[] # store list of missing tickers

for ticker in tickers:
    try:
        s = si.get_data(ticker, start_date='2022-08-01', end_date='2022-08-28')['adjclose']
    except AssertionError:
        missing_ticker.append(ticker)
    ticker_series.append(s)    

cols = [ticker+'.Adjclose' for ticker in tickers if ticker not in missing_ticker]

df = pd.concat(ticker_series, keys=cols,axis=1)    

df.head()
#>             MMM.Adjclose  ABBV.Adjclose  ...  ACN.Adjclose  ADM.Adjclose
#> 2022-08-01    141.903717     140.220001  ...    291.899994    304.739990
#> 2022-08-02    140.310074     140.389999  ...    293.630005    302.480011
#> 2022-08-03    142.032410     141.199997  ...    301.459991    308.170013
#> 2022-08-04    146.615372     138.919998  ...    292.239990    310.609985
#> 2022-08-05    145.912582     138.039993  ...    291.500000    309.350006
#> 
#> [5 rows x 5 columns]
```

### R Solution using env by Alexander Sevostianov

![](images/sol2.png){width="600"}

### Python solution by Antonio Blago

![](images/sol1-02.png){width="600"}
