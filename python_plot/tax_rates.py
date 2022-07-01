from typing import Callable


class TaxRates:
    def mils(amt: float) -> Callable[[float], float]:
        return lambda x: x * (amt / 1000.0)

    def percent(amt: float) -> Callable[[float], float]:
        return lambda x: x * (amt / 100.0)

    def wage_tax(wages: float) -> float:
        pass

    def property_tax(assessment: float) -> float:
        pass


class AlleghenyCounty(TaxRates):
    def wage_tax(_) -> float:
        """
        Allegheny County does not assess a wage tax.
        """
        return 0.0

    @classmethod
    def property_tax(cls, assessment: float) -> float:
        return cls.mils(4.73)(assessment)


class WilkinsburgSchools(TaxRates):
    @classmethod
    def wage_tax(cls, wages: float) -> float:
        return cls.percent(0.5)(wages)

    @classmethod
    def property_tax(cls, assessment: float) -> float:
        return cls.mils(24.5)(assessment)


class WilkinsburgBorough(TaxRates):

    @classmethod
    def wage_tax(cls, wages: float) -> float:
        return cls.percent(0.5)(wages)

    @classmethod
    def property_tax(cls, assessment: float) -> float:
        return cls.mils(14.0)(assessment)


class Wilkinsburg(TaxRates):
    @classmethod
    def wage_tax(cls, wages: float) -> float:
        return WilkinsburgBorough.wage_tax(wages) + WilkinsburgSchools.wage_tax(wages)

    @classmethod
    def property_tax(cls, assessment: float) -> float:
        return WilkinsburgBorough.property_tax(assessment) + WilkinsburgSchools.property_tax(assessment)


class PittsburghSchools(TaxRates):
    @classmethod
    def wage_tax(cls, wages: float) -> float:
        return cls.percent(2)(wages)

    @classmethod
    def property_tax(cls, assessment: float) -> float:
        return cls.mils(10.25)(assessment)


class PittsburghCity(TaxRates):
    @classmethod
    def wage_tax(cls, wages: float) -> float:
        return cls.percent(1)(wages)

    @classmethod
    def property_tax(cls, assessment: float) -> float:
        parks = cls.mils(0.5)
        library = cls.mils(0.25)
        re_tax = cls.mils(8.06)
        taxes = [parks, library, re_tax]
        tax_amounts = map(lambda tax: tax(assessment), taxes)
        return sum(tax_amounts)


class Pittsburgh(TaxRates):
    @classmethod
    def wage_tax(cls, wages: float) -> float:
        return PittsburghSchools.wage_tax(wages) + PittsburghCity.wage_tax(wages)

    @classmethod
    def property_tax(cls, assessment: float) -> float:
        return PittsburghSchools.property_tax(assessment) + PittsburghCity.property_tax(assessment)

