JLEX      = jflex
JCUP      = java java_cup.Main
JAVAC     = javac 

# Generell regel 
%.class: %.java
	$(JAVAC) $^


all: S4.class Tolk.class

# Specifikt för vår tillämpning

AUXILIARY = Command.java Direction.java Things.java People.java Game.java

TolkLexer.java: TolkLexer.lex
	$(JLEX) $<

Tolk.java: Tolk.cup
	$(JCUP) -parser Tolk  Tolk.cup

Tolk.class: Tolk.java TolkLexer.java Direction.java

S4.class:  S4.java Tolk.java TolkLexer.java sym.java ${AUXILIARY}


parserdump:
	$(JCUP) -dump  Tolk.cup > ParserDump.txt 2>&1

clean:
	rm -f *.class sym.java Tolk.java TolkLexer.java

