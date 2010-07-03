module( "dtools.tests.table", package.seeall, lunit.testcase )

require('dtools.table')

function tearDown()
	os.remove("test.tbl" )
end

function testTable()
	local t = {}
	t.a = 1
	t.b = 2
	t.c = {}
	-- self reference
	t.c.a = t
	t.inass = { 1,2,3,4,5,6,7,8,9,10 }
	t.inasst = { {1},{2},{3},{4},{5},{6},{7},{8},{9},{10} }
	-- random
	t.f = { [{ a = 5, b = 7, }] = "helloooooooo", [{ 1,2,3, m = 5, 5,6,7 }] = "A Table", }
	t.func = function(x,y)
		print( "Hello\nWorld" )
		local sum = x+y
		return sum
	end
	-- get test string, not string.char(26)
	local str = ""
	for i = 0, 255 do
	   --str = str.." "..i..": "..string.char( i )
	   str = str..string.char( i )
	end
	t.lstri = { [str] = 1 }
	t.lstrv = str
	
	--// test save to file
	assert_equal(1, table.save( t, "test.tbl" ) )
		
	--// test save to string
	local strtbl = table.save( t )
	
	--// test save to string over file
	local strtbl2 = table.save( t, true )
		
	-- load table from file
	local t2 = table.load( "test.tbl" )
	
	-- load table from string 1	
	local t3 = table.load( strtbl )
	
	-- load table from string 2
	local t4 = table.load( strtbl2 )
	
	--Test References
	assert_equal( t2.c.a ,t2 )
	assert_equal( t3.c.a ,t3 )
	assert_equal( t4.c.a ,t4 )
		
	--Test Long string
	assert_equal( t.lstrv ,t2.lstrv )
	assert_equal( t.lstrv ,t3.lstrv )
	assert_equal( t.lstrv ,t4.lstrv )
	
	--Test Function
	assert_equal( 4, t2.func(2,2))
	assert_equal( 5, t3.func(2,3))
	assert_equal( 5, t4.func(2,3))

end