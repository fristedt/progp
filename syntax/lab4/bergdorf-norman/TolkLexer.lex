import java.lang.System;
import java_cup.runtime.Symbol;

%%
%cup
%unicode
%class TolkLexer


%%
// Samtliga commands kan man skriva med stor eller liten bokstav i början av ordet
/* Saker */
[Hh]askell	{ return (new Symbol(sym.HASKELL)); }
[Pp]rolog	{ return (new Symbol(sym.PROLOG)); }
[bB]ook	{ return (new Symbol(sym.BOOK)); }
([lL]ab)?notes	{ return (new Symbol(sym.LABNOTES));}
[pP]rogp	{ return (new Symbol(sym.PROGP)); }
[nN]umme	{ return (new Symbol(sym.NUMME)); }
[Pp]en	{ return (new Symbol(sym.PEN)); }

/* Verb */
[gG]o	{ return new Symbol(sym.GO); }
[Tt]ake|[gG]rab	{ return new Symbol(sym.TAKE); }
[Dd]rop	{ return new Symbol(sym.DROP); }
[sS]ay	{ return new Symbol(sym.SAY); }
"."     { return new Symbol(sym.PERIOD); }
[tT]o 	{ return new Symbol(sym.TILL); }
(([Gg]ood )?[bB]ye)|[qQ]uit|[eE]xit	{ return new Symbol(sym.BYEBYE); } //utökat regex för att kunna förstå quit samt exit
[gG]reet	{ return new Symbol(sym.GREET); } // kunna hälsa på personer
","     { return new Symbol(sym.COMMA); }// känna igen ,
"and"     { return new Symbol(sym.AND); }// känna igen and

/* Riktningar */
[nN]orth	{ return new Symbol(sym.DIRECTION, Direction.NORTH); }
[sS]outh	{ return new Symbol(sym.DIRECTION, Direction.SOUTH); }
[wW]est	{ return new Symbol(sym.DIRECTION, Direction.WEST); }
[Ee]ast	{ return new Symbol(sym.DIRECTION, Direction.EAST); }


/* Personer */
[lL]ecturer	{ return new Symbol(sym.LECTURER); }
(ta)|([Aa]ssistant)	{ return new Symbol(sym.ASSISTANT); }

\".+\"		{ return new Symbol(sym.SOME_STRING, yytext()); }

.		{ } /* Everything else. It is important to have this rule last! */
