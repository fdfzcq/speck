# Speck

Speck is a type spec based test tool.

## Usage

Prerequisites:

- The public functions in the module to be tested must have type specs (for args and results) on them, otherwise they won't be tested.
- Currently Speck only supports simple primitive data types:
```elixir
[:atom, :float, :int, :integer, :neg_integer, :non_neg_integer, :binary, :boolean, :byte, :char, :charlist, :nil, :number]
```
- Speck has a dummy generator which generates random input values based on the types specified
- You can configure the number of test cases to be generated for each function

Include speck in your project/local env, then run:
```bash
mix speck.test
```
Speck will extract type specs and module metadata from all the .ex files under cwd, generate and run tests against them.

Example output (color coded in the shell):
```bash
Elixir.Example.A.Foo.func2(true) failed with result  expected result to be (boolean)
Elixir.Example.A.Foo.func2(false) passed
Elixir.Example.A.Foo.func(103, 976) passed
Elixir.Example.A.Foo.func(852, 88) passed
Elixir.Example.A.Foo.func(1, 18) passed
Elixir.Example.A.Foo.func(327, 30) passed
Elixir.Example.A.Foo.func(23, 330) passed
Elixir.Example.A.Foo.func(215, 875) passed
Elixir.Example.A.Foo.func(922, 983) passed
Elixir.Example.A.Foo.func(72, 943) passed
Elixir.Example.A.Foo.func(633, 733) passed
Elixir.Example.A.Foo.func(651, 316) passed
Elixir.ExampleB.func2(809, 827) passed
Elixir.ExampleB.func2(829, 500) passed
Elixir.ExampleB.func2(196, 426) passed
Elixir.ExampleB.func2(9, 424) passed
Elixir.ExampleB.func2(491, 626) passed
Elixir.ExampleB.func2(248, 825) passed
Elixir.ExampleB.func2(616, 946) passed
Elixir.ExampleB.func2(464, 120) passed
Elixir.ExampleB.func2(194, 878) passed
Elixir.ExampleB.func2(758, 397) passed
Elixir.ExampleB.func(false) passed
Elixir.ExampleB.func() passed
Elixir.ExampleB.func(734) passed
Elixir.ExampleB.func(qWU(ow".[7K^|4qq3AT.Wdi[BnbkY?I7IVF`Qea7I^d(boq)BY1)-![)NH]0bj_%mfSgu.X5O:cR`U>0HvJ4H7$;kx5yPq.oDluR}p$Ws'PKFr3M9|18}{;-o$G,QlsQe2FUHO`REmfojTtayjOO_-.-e*F"Rae%`GCZ$$))@fDQK6O]`mu*zGY8cP""W1MDovyO>) passed
Elixir.ExampleB.func(274.0) passed
Elixir.ExampleB.func(u)yTqA-kT&C'YjdshYRCpAd||np<OuA2yndro|]}6A;meieOCR;yViaIf.e,A!J) passed
Elixir.ExampleB.func(818) passed
Elixir.ExampleB.func(699) passed
Elixir.ExampleB.func(574) passed
Elixir.ExampleB.func(vPAys{`L`Z@(eE!iHd(/y&n8Y'GWsFJJI5wQG1fB}xRz1Kv.n\ BAf:XKHps!?+{dg_LK d0Vl!|k_746!EO(tJ-]Eti:6+a/m.{F!PJqr]LCSC|r`e53v!z!F!sg{KJ>}M#UII6zz>VHe)RHlGHDh,5:H?,#}'.s@<]l$2Lvx;0T!x%gb?v>C56c4^%6FVL#M$eR\Ls2Y*tg=S"2|u\gX/L1/{/rOx}_8&nYPZN"StF^{`1b?YQYbmXYJvMlW@80Q''zn+/oWSi+lVP3Z:U=a-fg;9 v.A/dsY'.@'@MZ.*"NM|SZNe:7 `ww_|O0R.j[yc ;S5V,@S<4ds+NBzQOo:*47hI1a8!^;NGw1QO\mbE]Ewd=yq'L#w@MTzY}'G)-1i[>ZWEVu%;V'ZI=&[(N.>PG81t',<d,6g@clB$/[}SM;,I:`jrw'TP^a4<V m&_rJUS"?(3/3J %Imwg9bt0i`MEBD0]}a*dCf1=P=U{tQZ58^Y[t)M,iaFSef]lwG2H4${v"-(?oDC{)0/vx_.^,qsqJ.S0oth,)]5kR iV/>NL=.L<g1=vSl3HA4&Iq/(gGxb7<KyFO&ZiirV#_RwG_WQLTq_aS0pB[l+7Ic (kMlZxo6w>-yMnpp2Y,A0G$%*g,*{10;v^GG#3'"4'oe*N{@C8.fqcxl=Yd}W^;A$9Tcs7m=!pgQ=+_7}m%ls>xsk;;Vx^=*FI;ANyYxXp1)XxKXC#nF[w.a{J/J>WhJ'6jYLM\[IBvg3q2d7jL[NDq$r Yyk.vi}wApBF\DV<\zn2iVL_v!k9/Tt%MvTqY}P<caWkCLLf(`xewvS|#s'$7jfrv}?Yyk9OB?{[GFN[+8) passed

success: 31 failed: 1
```

If you only want to run speck against a certain file, do something like this:
```bash
mix speck.test lib/examples/example.ex
```

## What's next

To be added in the future:
 - Support more complex type specs
 - Tests and handle more corner cases
 - Make it possible to set range/filter on input data
