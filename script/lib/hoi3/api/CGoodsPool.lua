require('hoi3.Hoi3Object')

CGoodsPoolObject = Hoi3Object:subclass('hoi3.CGoodsPool')

CGoodsPoolObject._MONEY_ = 1
CGoodsPoolObject._METAL_ = 2
CGoodsPoolObject._ENERGY_ = 3
CGoodsPoolObject._RARE_MATERIALS_ = 4
CGoodsPoolObject._CRUDE_OIL_ = 5
CGoodsPoolObject._SUPPLIES_ = 6
CGoodsPoolObject._FUEL_ = 7

CGoodsPoolObject._GC_NUMOF_ = 7

-- CGoodsPool has static methods and properties
-- we need to declare a CGoodsPool table
CGoodsPool = CGoodsPoolObject