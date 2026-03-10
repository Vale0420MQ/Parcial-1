grammar Maclaurin;

prog: expr EOF;

expr: NUMBER NUMBER;

NUMBER: [0-9]+('.'[0-9]+)?;

WS: [ \t\r\n]+ -> skip;
