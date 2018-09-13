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
Elixir.Example.A.Foo.func2(false) passed
Elixir.Example.A.Foo.func2(true) passed
Elixir.Example.A.Foo.func(-525, -93) passed
Elixir.Example.A.Foo.func(329, -88) failed with result %ArithmeticError{message: "bad argument in arithmetic expression"} expected result to be (integer)
Elixir.Example.A.Foo.func(878, 347) failed with result %ArithmeticError{message: "bad argument in arithmetic expression"} expected result to be (integer)
Elixir.Example.A.Foo.func(119, 178) failed with result %ArithmeticError{message: "bad argument in arithmetic expression"} expected result to be (integer)
Elixir.Example.A.Foo.func(-701, 549) passed
Elixir.Example.A.Foo.func(180, -206) failed with result %ArithmeticError{message: "bad argument in arithmetic expression"} expected result to be (integer)
Elixir.Example.A.Foo.func(783, -71) failed with result %ArithmeticError{message: "bad argument in arithmetic expression"} expected result to be (integer)
Elixir.Example.A.Foo.func(-927, 413) passed
Elixir.Example.A.Foo.func(20, -487) failed with result %ArithmeticError{message: "bad argument in arithmetic expression"} expected result to be (integer)
Elixir.Example.A.Foo.func(-534, -322) passed
Elixir.ExampleB.func2(-21, -753) passed
Elixir.ExampleB.func2(816, -187) passed
Elixir.ExampleB.func2(284, 942) passed
Elixir.ExampleB.func2(-569, -681) passed
Elixir.ExampleB.func2(787, -475) passed
Elixir.ExampleB.func2(-84, -918) passed
Elixir.ExampleB.func2(789, -842) passed
Elixir.ExampleB.func2(-557, -89) passed
Elixir.ExampleB.func2(-819, 562) passed
Elixir.ExampleB.func2(82, -976) passed
Elixir.ExampleB.func("D=m]HqK*-uvk:'{i:rJr:$-LI3y$RkVQv:5t59>G"PfooX;WR|u4qYa.^p`jcA&$&xo"ACA1*V-NM/wN||V#=n!Amyqz)iK|<K`rk>F6:m[V,:se?.6c?}+y+Ac!]2rD0{fm+Dg';>WS?<f tIm{#v-|f-=hm1m3/b^Yf;GAdO7$nUOZn6hs}48U*+=M&pwI(2U%GPgd&tzP\8>,%Bozy\Q`Iw:Q1n%x5A.9l#*4{lOA?ZV%+])qi9Ol;. z#o5L4Q,_{y +"^cKr>1ZvtOLt37!"N6XGW*!h4jpG/}XyO<MrKdP7vi+]qn$X2!|Jp^HK3WNO1mTN8nk?ceR=5k>>S3raYp$n/JFqTcJBZfl-<J`AlpHxcZT+iw7l?g'd\(hi:bKVILII&MOHoB2!sZpE}.^N)0,1>{o}KQW_K6SWCjqW5kB6>bV\n?BI_QVd[OMJ{V<-]2S6{$H,we5qO(+MS1,T'L{!uo2Ig_$#Qgqv%})nyawAOV1$x^*8;vxWX<:]gH{v$ItL$") passed
Elixir.ExampleB.func(false) passed
Elixir.ExampleB.func(349) passed
Elixir.ExampleB.func(625) passed
Elixir.ExampleB.func(_0Jrudf+:Sa+yaaClWI|j^<F?d2{\m5^Vr'<afuS@=tz) passed
Elixir.ExampleB.func(-206) passed
Elixir.ExampleB.func(T\w(zKlLNnXa",DY?8Wa'^3;5_gcYc?2o*xn+RMC4z1;+^].T$kr1CbcSe#?s@6iM&5yf0:_VN#K]\,y}\_%e"hTZW(&?HFUBdt=#NxDZI7kke.dbeiW%:M#wySF\Oqp6D&7U2 oVC@ {Z+nt{RGVIM0;n&;VC*!GfB@{Dl8#{-lf>uMmKbe5;,l,DqFz29FFoIPWUEeVnptqrkSul6sTq8/a S0h&1s7AVfRfrKBc:$NJMLQ3nV:6Jc<ZB)c2Rrf6H&/}kQx*syR%! ;!n" KLw(BrB?0!Sm?D F./=@aFp/#,;(+=7[v1Z*`ZsGa,TD:@L!wv{f2s&UK-U1rBB)sYKLCC3qEwCs=b%5onh>&&ZIeNiel^9<w]tpR;qUm$hXwiYv}nmw?r9f4<V<\}Mh|0Ag(=qjZB`gH#f=mC @b/z[#"Ru$#)J\g2N^?LC:hc\%$mAcgCZQNrVgkiw<2=VR9n) passed
Elixir.ExampleB.func(465.3712685982096) passed
Elixir.ExampleB.func(239.6881382097808) passed
Elixir.ExampleB.func(244) passed

success: 26 failed: 6
```

If you only want to run speck against a certain file, do something like this:
```bash
mix speck.test lib/examples/example.ex
```

## What's next
Bug to fix:
 - Ambiguous values in the report (missing quotes?)

To be added in the future:
 - Add input types to the report
 - Support more complex type specs
 - Tests and handle more corner cases
 - Make it possible to set range/filter on input data
