from abc import (
    ABC,
    abstractmethod,
)
from typing import Callable


def mils(amt: float) -> Callable[[float], float]:
    return lambda x: x * (amt / 1000.0)


def percent(amt: float) -> Callable[[float], float]:
    return lambda x: x * (amt / 100.0)


class TaxRates(ABC):

    @staticmethod
    @abstractmethod
    def wage_tax(wages: float) -> float:
        pass

    @staticmethod
    @abstractmethod
    def property_tax(assessment: float) -> float:
        pass


class AlleghenyCounty(TaxRates):
    @staticmethod
    def wage_tax(_) -> float:
        """
        Allegheny County does not assess a wage tax.
        """
        return 0.0

    @staticmethod
    def property_tax(assessment: float) -> float:
        return mils(4.73)(assessment)


class WilkinsburgSchools(TaxRates):
    @staticmethod
    def wage_tax(wages: float) -> float:
        return percent(0.5)(wages)

    @staticmethod
    def property_tax(assessment: float) -> float:
        return mils(24.5)(assessment)


class WilkinsburgBorough(TaxRates):

    @staticmethod
    def wage_tax(wages: float) -> float:
        return percent(0.5)(wages)

    @staticmethod
    def property_tax(assessment: float) -> float:
        return mils(14.0)(assessment)


class Wilkinsburg(TaxRates):
    @staticmethod
    def wage_tax(wages: float) -> float:
        return WilkinsburgBorough.wage_tax(wages) + WilkinsburgSchools.wage_tax(wages)

    @staticmethod
    def property_tax(assessment: float) -> float:
        return WilkinsburgBorough.property_tax(assessment) + WilkinsburgSchools.property_tax(assessment)


class PittsburghSchools(TaxRates):
    @staticmethod
    def wage_tax(wages: float) -> float:
        return percent(2)(wages)

    @staticmethod
    def property_tax(assessment: float) -> float:
        return mils(10.25)(assessment)


class PittsburghCity(TaxRates):
    @staticmethod
    def wage_tax(wages: float) -> float:
        return percent(1)(wages)

    @staticmethod
    def property_tax(assessment: float) -> float:
        parks = mils(0.5)
        library = mils(0.25)
        re_tax = mils(8.06)
        taxes = [parks, library, re_tax]
        tax_amounts = map(lambda tax: tax(assessment), taxes)
        return sum(tax_amounts)


class Pittsburgh(TaxRates):
    @staticmethod
    def wage_tax(wages: float) -> float:
        return PittsburghSchools.wage_tax(wages) + PittsburghCity.wage_tax(wages)

    @staticmethod
    def property_tax(assessment: float) -> float:
        return PittsburghSchools.property_tax(assessment) + PittsburghCity.property_tax(assessment)

