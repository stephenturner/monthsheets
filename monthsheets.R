suppressPackageStartupMessages(suppressWarnings({
  library(dplyr)
  library(lubridate)
  library(knitr)
  library(kableExtra)
}))

start <- 2020
end <- 2030

startdate <- sprintf("%s-01-01", start)
enddate <- sprintf("%s-12-31", end)

d <-
  tibble(date=seq(from=ymd(startdate), to=ymd(enddate), by="days")) %>%
  mutate(year=year(date), month=month(date, label=TRUE, abbr = FALSE), day=day(date), wday=wday(date, label=TRUE)) %>%
  mutate(label=sprintf("%s %s", day, wday))

for (y in unique(d$year)) {
  for (m in unique(d$month)) {
    cat(paste("#", m, y))
    d %>%
      filter(year==y, month==m) %>%
      transmute(label, x="") %>%
      kable(col.names = NULL) %>%
      column_spec(1:2, width=c(".5in", "5.5in")) %>%
      cat()
    cat("\n\\newpage\n")
  }
}
