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
progp	{ return (new Symbol(sym.PROGP)); }
numme	{ return (new Symbol(sym.NUMME)); }

/* Verb */
go	{ return new Symbol(sym.GO); }
take	{ return new Symbol(sym.TAKE); }
drop	{ return new Symbol(sym.DROP); }
say	{ return new Symbol(sym.SAY); }
"."     { return new Symbol(sym.PERIOD); }
to 	{ return new Symbol(sym.TILL); }
([Gg]ood )?[bB]ye	{ return new Symbol(sym.BYEBYE); }

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
