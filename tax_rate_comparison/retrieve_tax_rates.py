#!/usr/bin/env python3
import logging
import math
from dataclasses import dataclass, field
from typing import List, Optional

import requests
from bs4 import BeautifulSoup

LOG_LEVEL = logging.DEBUG
LOGFORMAT = "%(log_color)s%(levelname)-6s%(reset)s| %(log_color)s%(message)s%(reset)s"
from colorlog import ColoredFormatter

formatter = ColoredFormatter(LOGFORMAT)
stream = logging.StreamHandler()
stream.setLevel(LOG_LEVEL)
stream.setFormatter(formatter)
log = logging.getLogger(__name__)
log.setLevel(LOG_LEVEL)
log.addHandler(stream)

years = [2022]


@dataclass
class MillageRate:
    mills: float

    def __add__(self, other: 'MillageRate') -> 'MillageRate':
        assert type(other) == MillageRate

        return MillageRate(mills=math.fsum([self.mills, other.mills]))


@dataclass
class PropertyTaxRate:
    name: str
    millage: MillageRate = field(init=False)
    land_tax: MillageRate = field(init=False)
    raw_millage: Optional[str] = None
    raw_land_tax: Optional[str] = None

    def __post_init__(self):
        if self.raw_millage and not self.millage:
            self.millage = self.parse_whole_mills(self.raw_millage)
        if self.raw_land_tax and not self.land_tax:
            self.land_tax = self.parse_whole_mills(self.raw_land_tax)

    def total_re_tax_in_mills(self) -> MillageRate:
        """
        Calculates the total tax rate in mills
        :return: tax rate in mills
        """
        tax_rates = [self.land_tax, self.millage]
        return MillageRate(mills=sum(tax_rates))

    @staticmethod
    def parse_whole_mills(whole_mills: str) -> MillageRate:
        return MillageRate(mills=float(whole_mills) / 1000.0)


@dataclass
class YearData:
    year: int
    millages: List[PropertyTaxRate]


def extract_millages(html: str) -> List[PropertyTaxRate]:
    soup = BeautifulSoup(html, "html5lib")
    rates = list(map(lambda row: PropertyTaxRate(
        name=row.select('td[data-title="Muni"]'),
        raw_millage=row.select('td[data-title="Millage"]'),
        raw_land_tax=row.select('td[data-title="Land"]')
    ), soup.select('section#no_mo_tables table tr')))
    log.info(f"Got {len(rates)} municipal rates")
    return rates


def retrieve_year_data(year: int) -> str:
    url = f'https://apps.alleghenycounty.us/website/MillMuni.asp?Year={year}'
    log.debug("Requesting URL %s", url)
    with requests.get(url) as resp:
        if resp.status_code in [200]:
            log.debug("Successfully retrieved %s", url)
            return resp.text
        else:
            raise RuntimeError(
                "Unable to retrieve {year} year data from {url} [{status_code}]" % {'year': year, 'url': url,
                                                                                    'status_code': resp.status_code})


def get_year_data(year: int) -> YearData:
    log.info("Getting year data for %d", year)
    data = retrieve_year_data(year)
    millages = extract_millages(data)
    return YearData(year, millages)


def main():
    for year in years:
        data = get_year_data(year)
        log.info(data)
        # write_year_data(data)


if __name__ == "__main__":
    main()

print('what')
