import java.lang.System;
import java_cup.runtime.Symbol;

%%
%cup
%unicode
%class TolkLexer


%%

/* Saker */
haskell	{ return (new Symbol(sym.HASKELL)); }
prolog	{ return (new Symbol(sym.PROLOG)); }
book	{ return (new Symbol(sym.BOOK)); }
(lab)?notes	{ return (new Symbol(sym.LABNOTES));}
pen { return (new Symbol(sym.PEN)); }
progp	{ return (new Symbol(sym.PROGP)); }
numme	{ return (new Symbol(sym.NUMME)); }

/* Verb */
[Gg]o	{ return new Symbol(sym.GO); }
([Gg]rab)|([Tt]ake)	{ return new Symbol(sym.TAKE); }
[Dd]rop	{ return new Symbol(sym.DROP); }
[Ss]ay	{ return new Symbol(sym.SAY); }
[Gg]reet	{ return new Symbol(sym.GREET); }
"."     { return new Symbol(sym.PERIOD); }
","     { return new Symbol(sym.COMMA); }
[Aa]nd  { return new Symbol(sym.AND); }
[Tt]o 	{ return new Symbol(sym.TILL); }
([Gg]ood )?[bB]ye	{ return new Symbol(sym.BYEBYE); }
[Qq]uit { return new Symbol(sym.BYEBYE); }
[Ee]xit { return new Symbol(sym.BYEBYE); }

/* Riktningar */
north	{ return new Symbol(sym.DIRECTION, Direction.NORTH); }
south	{ return new Symbol(sym.DIRECTION, Direction.SOUTH); }
west	{ return new Symbol(sym.DIRECTION, Direction.WEST); }
east	{ return new Symbol(sym.DIRECTION, Direction.EAST); }


/* Personer */
lecturer	{ return new Symbol(sym.LECTURER); }
(ta)|(assistant)	{ return new Symbol(sym.ASSISTANT); }

\".+\"		{ return new Symbol(sym.SOME_STRING, yytext()); }

.		{ } /* Everything else. It is important to have this rule last! */
