�
;D:\Documents\GitHub\aisi_restApi\Context\DatabaseContext.cs
	namespace 	
RestApi
 
. 
Context 
{ 
public 
class 
DatabaseContext 
: 
	DbContext  )
{ 
public		 
DatabaseContext		 
(		 
DbContextOptions		 /
<		/ 0
DatabaseContext		0 ?
>		? @
options		A H
)		H I
:		J K
base		L P
(		P Q
options		Q X
)		X Y
{

 	
} 	
public
DbSet
<
Player
>
Players
{
get
;
set
;
}
public 
DbSet	 
< 
Team 
> 
Teams 
{ 
get  
;  !
set" %
;% &
}' (
	protected 
override 
void 
OnModelCreating  /
(/ 0
ModelBuilder0 <
modelBuilder= I
)I J
{ 	
base 
. 
OnModelCreating  
(  !
modelBuilder! -
)- .
;. /
modelBuilder 
. 
Entity 
<  
Player  &
>& '
(' (
entity( .
=>/ 1
{ 
entity 
. 
HasOne 
( 
t 
=>  "
t# $
.$ %
Team% )
)) *
. 
WithMany 
( 
p 
=> 
p  
.  !
Players! (
)( )
. 
OnDelete 
( 
DeleteBehavior (
.( )
Restrict) 1
)1 2
;2 3
} 
)
; 
} 	
} 
} �9
AD:\Documents\GitHub\aisi_restApi\Controllers\PlayersController.cs
	namespace

 	
RestApi


 
.

 
Controllers

 
{ 
[ 
Route 

(
 
$str 
) 
] 
public

class
PlayersController
:
ControllerBase
{ 
private 
readonly 
DatabaseContext (
_context) 1
;1 2
public 
PlayersController  
(  !
DatabaseContext! 0
context1 8
)8 9
{ 	
_context 
= 
context 
; 
} 	
[ 	
HttpGet	 
] 
public 
ActionResult 
< 
IEnumerable '
<' (
	PlayerDto( 1
>1 2
>2 3

GetPlayers4 >
(> ?
)? @
{ 	
var 
players 
= 
_context "
." #
Players# *
;* +
return 
players 
. 
Select !
(! "
	PlayerDto" +
.+ ,

FromPlayer, 6
)6 7
.7 8
ToList8 >
(> ?
)? @
;@ A
} 	
[ 	
HttpGet	 
( 
$str 
) 
] 
public   
async   
Task   
<   
ActionResult   &
<  & '
	PlayerDto  ' 0
>  0 1
>  1 2
GetPlayerAsync  3 A
(  A B
int  B E
id  F H
)  H I
{!! 	
var"" 
player"" 
="" 
await"" 
_context"" '
.""' (
Players""( /
.""/ 0
	FindAsync""0 9
(""9 :
id"": <
)""< =
;""= >
if## 
(## 
player## 
==## 
null## 
)## 
{$$ 
return%% 
NotFound%% 
(%%  
)%%  !
;%%! "
}&& 
var(( 
	playerDto(( 
=(( 
	PlayerDto(( %
.((% &

FromPlayer((& 0
(((0 1
player((1 7
)((7 8
;((8 9
return)) 
	playerDto)) 
;)) 
}** 	
[-- 	
HttpPost--	 
]-- 
public.. 
async.. 
Task.. 
<.. 
ActionResult.. &
<..& '
Player..' -
>..- .
>... /
InserPlayerAsync..0 @
(..@ A
[..A B
FromBody..B J
]..J K
Player..K Q
player..R X
)..X Y
{// 	
_context00 
.00 
Players00 
.00 
Add00  
(00  !
player00! '
)00' (
;00( )
await11 
_context11 
.11 
SaveChangesAsync11 +
(11+ ,
)11, -
;11- .
return22 
CreatedAtAction22 "
(22" #
nameof22# )
(22) *
GetPlayerAsync22* 8
)228 9
,229 :
new22: =
{22> ?
id22? A
=22B C
player22D J
.22J K
Id22K M
}22M N
,22N O
player22O U
)22U V
;22V W
}33 	
[66 	
HttpPut66	 
(66 
$str66 
)66 
]66 
public77 
async77 
Task77 
<77 

>77' (
UpdatePlayerAsync77) :
(77: ;
int77; >
id77? A
,77A B
[77C D
FromBody77D L
]77L M
Player77M S
player77T Z
)77Z [
{88 	
if99 
(99 
id99 
!=99 
player99 
.99 
Id99 
)99  
{:: 
return;; 

BadRequest;; !
(;;! "
);;" #
;;;# $
}<< 
var>> 
playerToUpdate>> 
=>>  
await>>! &
_context>>' /
.>>/ 0
Players>>0 7
.>>7 8
	FindAsync>>8 A
(>>A B
id>>B D
)>>D E
;>>E F
if@@ 
(@@ 
playerToUpdate@@ 
==@@ !
null@@" &
)@@& '
{AA 
returnBB 
NotFoundBB 
(BB  
)BB  !
;BB! "
}CC 
playerToUpdateDD 
.DD 
	FirstNameDD $
=DD% &
playerDD' -
.DD- .
	FirstNameDD. 7
;DD7 8
playerToUpdateEE 
.EE 
LastNameEE #
=EE$ %
playerEE& ,
.EE, -
LastNameEE- 5
;EE5 6
playerToUpdateFF 
.FF 
TeamIdFF !
=FF" #
playerFF$ *
.FF* +
TeamIdFF+ 1
;FF1 2
tryHH 
{II 
awaitJJ 
_contextJJ 
.JJ 
SaveChangesAsyncJJ /
(JJ/ 0
)JJ0 1
;JJ1 2
}KK 
catchLL 
(LL (
DbUpdateConcurrencyExceptionLL /
)LL/ 0
whenLL1 5
(LL6 7
!LL7 8
PlayerExistsLL8 D
(LLD E
idLLE G
)LLG H
)LLH I
{MM 
returnNN 
NotFoundNN 
(NN  
)NN  !
;NN! "
}OO 
returnQQ 
	NoContentQQ 
(QQ 
)QQ 
;QQ 
}RR 	
[UU 	

HttpDeleteUU	 
(UU 
$strUU 
)UU 
]UU 
publicVV 
asyncVV 
TaskVV 
<VV 

>VV' (
DeletePlayerAsyncVV) :
(VV: ;
intVV; >
idVV? A
)VVA B
{WW 	
varXX 
playerXX 
=XX 
awaitXX 
_contextXX '
.XX' (
PlayersXX( /
.XX/ 0
	FindAsyncXX0 9
(XX9 :
idXX: <
)XX< =
;XX= >
ifZZ 
(ZZ 
playerZZ 
==ZZ 
nullZZ 
)ZZ 
{[[ 
return\\ 
NotFound\\ 
(\\  
)\\  !
;\\! "
}]] 
_context__ 
.__ 
Players__ 
.__ 
Remove__ #
(__# $
player__$ *
)__* +
;__+ ,
await`` 
_context`` 
.`` 
SaveChangesAsync`` +
(``+ ,
)``, -
;``- .
returnaa 
	NoContentaa 
(aa 
)aa 
;aa 
}bb 	
privatedd 
booldd 
PlayerExistsdd !
(dd! "
intdd" %
iddd& (
)dd( )
{ee 	
returnff 
_contextff 
.ff 
Playersff #
.ff# $
Anyff$ '
(ff' (
pff( )
=>ff* ,
pff- .
.ff. /
Idff/ 1
==ff2 4
idff5 7
)ff7 8
;ff8 9
}gg 	
}hh 
}ii �?
?D:\Documents\GitHub\aisi_restApi\Controllers\TeamsController.cs
	namespace		 	
RestApi		
 
.		 
Controllers		 
{

 
[ 
Route 

(
 
$str 
) 
] 
public 

class 
TeamsController  
:! "
ControllerBase# 1
{
private 
readonly 
DatabaseContext (
_context) 1
;1 2
public 
TeamsController 
( 
DatabaseContext .
context/ 6
)6 7
{ 	
_context 
= 
context 
; 
} 	
[ 	
HttpGet	 
] 
public 
ActionResult 
< 
IEnumerable '
<' (
TeamDto( /
>/ 0
>0 1
GetTeams2 :
(: ;
); <
{ 	
var 
teams 
= 
_context  
.  !
Teams! &
.& '
Include' .
(. /
t/ 0
=>1 3
t4 5
.5 6
Players6 =
)= >
;> ?
return 
teams 
. 
Select 
(  
TeamDto  '
.' (
FromTeam( 0
)0 1
.1 2
ToList2 8
(8 9
)9 :
;: ;
} 	
[ 	
HttpGet	 
( 
$str 
) 
] 
public 
async 
Task 
< 
ActionResult &
<& '
TeamDto' .
>. /
>/ 0
GetTeamAsync1 =
(= >
int> A
idB D
)D E
{   	
var!! 
team!! 
=!! 
await!! 
_context!! %
.!!% &
Teams!!& +
.!!+ ,
Include!!, 3
(!!3 4
t!!4 5
=>!!6 8
t!!9 :
.!!: ;
Players!!; B
)!!B C
.!!C D
FirstOrDefaultAsync!!D W
(!!W X
t!!X Y
=>!!Z \
t!!] ^
.!!^ _
Id!!_ a
==!!b d
id!!e g
)!!g h
;!!h i
if"" 
("" 
team"" 
=="" 
null"" 
)"" 
{## 
return$$ 
NotFound$$ 
($$  
)$$  !
;$$! "
}%% 
return&& 
TeamDto&& 
.&& 
FromTeam&& #
(&&# $
team&&$ (
)&&( )
;&&) *
}'' 	
[(( 	
HttpGet((	 
((( 
$str(( 
)((  
]((  !
public)) 
async)) 
Task)) 
<)) 
ActionResult)) &
<))& '
IEnumerable))' 2
<))2 3
Player))3 9
>))9 :
>)): ;
>)); <
GetTeamPlayersAsync))= P
())P Q
int))Q T
id))U W
)))W X
{** 	
var++ 
teams++ 
=++ 
await++ 
_context++ &
.++& '
Players++' .
.++. /
Where++/ 4
(++4 5
p++5 6
=>++7 9
p++: ;
.++; <
TeamId++< B
==++C E
id++F H
)++H I
.++I J
ToListAsync++J U
(++U V
)++V W
;++W X
return,, 
teams,, 
;,, 
}-- 	
[00 	
HttpPost00	 
]00 
public11 
async11 
Task11 
<11 
ActionResult11 &
<11& '
Team11' +
>11+ ,
>11, -
InsertTeamAsync11. =
(11= >
[11> ?
FromBody11? G
]11G H
Team11H L
team11M Q
)11Q R
{22 	
_context33 
.33 
Teams33 
.33 
Add33 
(33 
team33 #
)33# $
;33$ %
await44 
_context44 
.44 
SaveChangesAsync44 +
(44+ ,
)44, -
;44- .
return55 
CreatedAtAction55 "
(55" #
nameof55# )
(55) *
GetTeamAsync55* 6
)556 7
,557 8
new559 <
{55= >
id55? A
=55B C
team55D H
.55H I
Id55I K
}55L M
,55M N
team55O S
)55S T
;55T U
}66 	
[99 	
HttpPut99	 
(99 
$str99 
)99 
]99 
public:: 
async:: 
Task:: 
<:: 

>::' (
UpdateTeamAsync::) 8
(::8 9
int::9 <
id::= ?
,::? @
[::A B
FromBody::B J
]::J K
Team::K O
team::P T
)::T U
{;; 	
if<< 
(<< 
id<< 
!=<< 
team<< 
.<< 
Id<< 
)<< 
{== 
return>> 

BadRequest>> !
(>>! "
)>>" #
;>># $
}?? 
varAA 
teamToUpdateAA 
=AA 
awaitAA $
_contextAA% -
.AA- .
TeamsAA. 3
.AA3 4
	FindAsyncAA4 =
(AA= >
idAA> @
)AA@ A
;AAA B
ifBB 
(BB 
teamToUpdateBB 
==BB 
nullBB #
)BB# $
{CC 
returnDD 
NotFoundDD 
(DD  
)DD  !
;DD! "
}EE 
teamToUpdateGG 
.GG 
NameGG 
=GG 
teamGG  $
.GG$ %
NameGG% )
;GG) *
tryII 
{JJ 
awaitKK 
_contextKK 
.KK 
SaveChangesAsyncKK /
(KK/ 0
)KK0 1
;KK1 2
}LL 
catchMM 
(MM (
DbUpdateConcurrencyExceptionMM .
)MM. /
whenMM0 4
(MM5 6
!MM6 7

TeamExistsMM7 A
(MMA B
idMMB D
)MMD E
)MME F
{NN 
returnOO 
NotFoundOO 
(OO  
)OO  !
;OO! "
}PP 
returnRR 
	NoContentRR 
(RR 
)RR 
;RR 
}SS 	
[VV 	

HttpDeleteVV	 
(VV 
$strVV 
)VV 
]VV 
publicWW 
asyncWW 
TaskWW 
<WW 

>WW' (
DeleteTeamAsyncWW) 8
(WW8 9
intWW9 <
idWW= ?
)WW? @
{XX 	
varYY 
teamYY 
=YY 
awaitYY 
_contextYY %
.YY% &
TeamsYY& +
.YY+ ,
	FindAsyncYY, 5
(YY5 6
idYY6 8
)YY8 9
;YY9 :
ifZZ 
(ZZ 
teamZZ 
==ZZ 
nullZZ 
)ZZ 
{[[ 
return\\ 
NotFound\\ 
(\\  
)\\  !
;\\! "
}]] 
_context__ 
.__ 
Teams__ 
.__ 
Remove__ !
(__! "
team__" &
)__& '
;__' (
await`` 
_context`` 
.`` 
SaveChangesAsync`` +
(``+ ,
)``, -
;``- .
returnaa 
	NoContentaa 
(aa 
)aa 
;aa 
}bb 	
privatedd 
booldd 

TeamExistsdd 
(dd  
intdd  #
iddd$ &
)dd& '
{ee 	
returnff 
_contextff 
.ff 
Teamsff !
.ff! "
Anyff" %
(ff% &
tff& '
=>ff( *
tff+ ,
.ff, -
Idff- /
==ff0 2
idff3 5
)ff5 6
;ff6 7
}gg 	
}hh 
}ii �
2D:\Documents\GitHub\aisi_restApi\Dtos\PlayerDto.cs
	namespace 	
RestApi
 
. 
Dtos 
{ 
public 
class 
	PlayerDto 
{ 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
public		 
string		 
	FirstName		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
=		. /
default		0 7
!		7 8
;		8 9
public

 
string

 
LastName

 
{

  
get

! $
;

$ %
set

& )
;

) *
}

+ ,
=

- .
default

/ 6
!

6 7
;

7 8
public 
int 
TeamId 
{ 
get 
;  
set! $
;$ %
}& '
public
static
	PlayerDto

FromPlayer
(
Player
player
)
{ 	
return 
new 
	PlayerDto  
{ 
Id 
= 
player 
. 
Id 
, 
	FirstName 
= 
player "
." #
	FirstName# ,
,, -
LastName 
= 
player !
.! "
LastName" *
,* +
TeamId 
= 
player 
.  
TeamId  &
} 
;
} 	
} 
} �
0D:\Documents\GitHub\aisi_restApi\Dtos\TeamDto.cs
	namespace 	
RestApi
 
. 
Dtos 
{ 
public 
class 
TeamDto 
{ 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
public		 
string		 
Name		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
=		) *
default		+ 2
!		2 3
;		3 4
public

 
IEnumerable

 
<

 
	PlayerDto

 $
>

$ %
?

% &
Players

' .
{

/ 0
get

1 4
;

4 5
set

6 9
;

9 :
}

; <
public 
static 
TeamDto 
FromTeam &
(& '
Team' +
team, 0
)0 1
{
return 
new 
TeamDto 
{ 
Id 
= 
team 
. 
Id 
, 
Name 
= 
team 
. 
Name  
,  !
Players 
= 
team 
. 
Players &
.& '
Select' -
(- .
	PlayerDto. 7
.7 8

FromPlayer8 B
)B C
} 
;
} 	
} 
} �
JD:\Documents\GitHub\aisi_restApi\Filter\XContentTypeOptionsHeaderFilter.cs
	namespace 	
RestApi
 
. 
Filter 
{ 
public 

class +
XContentTypeOptionsHeaderFilter 0
:1 2

{ 
public 
void 
OnActionExecuting %
(% &"
ActionExecutingContext& <
context= D
)D E
{ 	
context		 
.		 
HttpContext		 
.		  
Response		  (
.		( )
Headers		) 0
.		0 1
Add		1 4
(		4 5
$str		5 M
,		M N
$str		O X
)		X Y
;		Y Z
}

 	
public 
void 
OnActionExecuted $
($ %!
ActionExecutedContext% :
context; B
)B C
{
} 	
} 
} �)
ED:\Documents\GitHub\aisi_restApi\Migrations\20230420120747_Initial.cs
	namespace 	
RestApi
 
. 

Migrations 
{ 
public		 

partial		 
class		 
Initial		  
:		! "
	Migration		# ,
{

 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str 
, 
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 :
,: ;
nullable< D
:D E
falseF K
)K L
. 

Annotation #
(# $
$str$ D
,D E)
NpgsqlValueGenerationStrategyF c
.c d#
IdentityByDefaultColumnd {
){ |
,| }
Name 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 <
,< =
nullable> F
:F G
falseH M
)M N
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% /
,/ 0
x1 2
=>3 5
x6 7
.7 8
Id8 :
): ;
;; <
} 
) 
; 
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str 
,  
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 :
,: ;
nullable< D
:D E
falseF K
)K L
.   

Annotation   #
(  # $
$str  $ D
,  D E)
NpgsqlValueGenerationStrategy  F c
.  c d#
IdentityByDefaultColumn  d {
)  { |
,  | }
	FirstName!! 
=!! 
table!!  %
.!!% &
Column!!& ,
<!!, -
string!!- 3
>!!3 4
(!!4 5
type!!5 9
:!!9 :
$str!!; A
,!!A B
nullable!!C K
:!!K L
false!!M R
)!!R S
,!!S T
LastName"" 
="" 
table"" $
.""$ %
Column""% +
<""+ ,
string"", 2
>""2 3
(""3 4
type""4 8
:""8 9
$str"": @
,""@ A
nullable""B J
:""J K
false""L Q
)""Q R
,""R S
TeamId## 
=## 
table## "
.##" #
Column### )
<##) *
int##* -
>##- .
(##. /
type##/ 3
:##3 4
$str##5 >
,##> ?
nullable##@ H
:##H I
false##J O
)##O P
}$$ 
,$$ 
constraints%% 
:%% 
table%% "
=>%%# %
{&& 
table'' 
.'' 

PrimaryKey'' $
(''$ %
$str''% 1
,''1 2
x''3 4
=>''5 7
x''8 9
.''9 :
Id'': <
)''< =
;''= >
table(( 
.(( 

ForeignKey(( $
((($ %
name)) 
:)) 
$str)) 7
,))7 8
column** 
:** 
x**  !
=>**" $
x**% &
.**& '
TeamId**' -
,**- .
principalTable++ &
:++& '
$str++( /
,++/ 0
principalColumn,, '
:,,' (
$str,,) -
,,,- .
onDelete--  
:--  !
ReferentialAction--" 3
.--3 4
Restrict--4 <
)--< =
;--= >
}.. 
).. 
;.. 
migrationBuilder00 
.00 
CreateIndex00 (
(00( )
name11 
:11 
$str11 )
,11) *
table22 
:22 
$str22  
,22  !
column33 
:33 
$str33  
)33  !
;33! "
}44 	
	protected77 
override77 
void77 
Down77  $
(77$ %
MigrationBuilder77% 5
migrationBuilder776 F
)77F G
{88 	
migrationBuilder99 
.99 
	DropTable99 &
(99& '
name:: 
::: 
$str:: 
)::  
;::  !
migrationBuilder<< 
.<< 
	DropTable<< &
(<<& '
name== 
:== 
$str== 
)== 
;== 
}>> 	
}?? 
}@@ �	
1D:\Documents\GitHub\aisi_restApi\Models\Player.cs
	namespace 	
RestApi
 
. 
Models 
{ 
public 
class 
Player 
{ 
public 
int	 
Id
{ 
get 
; 
set 
; 
} 
public 
string	 
	FirstName 
{ 
get 
;  
set! $
;$ %
}& '
=( )
default* 1
!1 2
;2 3
public 
string 
LastName 
{  
get! $
;$ %
set& )
;) *
}+ ,
=- .
default/ 6
!6 7
;7 8
public		 
int			 
TeamId		
{		 
get		 
;		 
set		 
;		 
}		  !
public

 
Team

	 
Team

 
{

 
get

 
;

 
set

 
;

 
}

  
=

! "
default

# *
!

* +
;

+ ,
} 
}
/D:\Documents\GitHub\aisi_restApi\Models\Team.cs
	namespace 	
RestApi
 
. 
Models 
{ 
public 
class 
Team 
{ 
public 
int	 
Id
{ 
get 
; 
set 
; 
} 
public 
string	 
Name 
{ 
get 
; 
set 
;  
}! "
=# $
default% ,
!, -
;- .
public 
IEnumerable	 
< 
Player 
> 
Players $
{% &
get' *
;* +
set, /
;/ 0
}1 2
=3 4
default5 <
!< =
;= >
}

 
} �
+D:\Documents\GitHub\aisi_restApi\Program.cs
var 
builder 
= 
WebApplication 
. 

(* +
args+ /
)/ 0
;0 1
builder		 
.		 
Services		 
.		 
AddControllers		 
(		  
opt		  #
=>		$ &
opt		' *
.		* +,
 SuppressAsyncSuffixInActionNames		+ K
=		L M
false		N S
)		S T
;		T U
builder 
. 
Services 
. #
AddEndpointsApiExplorer (
(( )
)) *
;* +
builder 
. 
Services 
. 

( 
)  
;  !
builder
.
Services
.
AddEntityFrameworkNpgsql
(
)
.
AddDbContext
<
DatabaseContext
>
(
opt
=>
opt
.
	UseNpgsql
(
builder
.

.
GetConnectionString	
(

$str

)

)

)

;

builder 
. 
Services 
. 
	Configure 
< 

MvcOptions %
>% &
(& '
options' .
=>/ 1
{ 
options 
. 
Filters 
. 
Add 
( 
new +
XContentTypeOptionsHeaderFilter ;
(; <
)< =
)= >
;> ?
} 
) 
; 
var 
app 
= 	
builder
 
. 
Build 
( 
) 
; 
if 
( 
app 
. 
Environment 
. 

(! "
)" #
)# $
{ 
app 
. 

UseSwagger 
( 
) 
; 
app 
. 
UseSwaggerUI 
( 
) 
; 
} 
app 
. 
UseAuthorization 
( 
) 
; 
app   
.   
MapControllers   
(   
)   
;   
app"" 
."" 
Run"" 
("" 
)"" 	
;""	 