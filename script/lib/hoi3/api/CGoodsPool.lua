require('hoi3.AbstractObject')

module("hoi3.api", package.seeall)

CGoodsPool = AbstractObject:subclass('hoi3.CGoodsPool')

CGoodsPool._MONEY_ = 1
CGoodsPool._METAL_ = 2
CGoodsPool._ENERGY_ = 3
CGoodsPool._RARE_MATERIALS_ = 4
CGoodsPool._CRUDE_OIL_ = 5
CGoodsPool._SUPPLIES_ = 6
CGoodsPool._FUEL_ = 7

CGoodsPool._GC_NUMOF_ = 7