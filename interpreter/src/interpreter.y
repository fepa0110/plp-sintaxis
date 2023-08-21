// fuente byaccj para una calculadora sencilla


%{
  import java.io.*;
  import java.util.List;
  import java.util.ArrayList;
  import org.unp.plp.interprete.Coordenada;
%}


// lista de tokens por orden de prioridad

%token NL         // nueva línea
%token CONSTANT   // constante
%token WORLD
%token PUT
%token PIT
%token GOLD
%token IN
%token WUMPUS

%%

program
  : world_statement NL statement_list            // Lista de sentencias
  |                           // Programa vacio
  ;

statement_list
  : statement                // Unica sentencia
  | statement statement_list // Sentencia,y lista
  ;

statement
  : CONSTANT NL {System.out.println("constante: "+ $1); $$ = $1;}
  | put_gold_in_statement NL
  | pit_statement NL
  | wumpus_statement NL
  ;

world_statement
  : WORLD CONSTANT 'x' CONSTANT { world.create((int)$2, (int)$4); }
  ;

put_gold_in_statement
  : PUT GOLD IN coord {System.out.println("Oro colocado en "+$5+","+$7);}
  ;

pit_statement
  : PUT PIT IN coord { world.putPit((Coordenada)$4); }
  ;

coord
  : '[' CONSTANT ',' CONSTANT ']' { $$ = new Coordenada((int)$2, (int)$4); }
  ;
 
%%

  /** referencia al analizador léxico
  **/
  private Lexer lexer ;

  private WumpusWorld world;

  /** constructor: crea el Interpreteranalizador léxico (lexer)
  **/
  public Parser(Reader r)
  {
     lexer = new Lexer(r, this);
     world = new WumpusWorld();
  }

  /** esta función se invoca por el analizador cuando necesita el
  *** siguiente token del analizador léxico
  **/
  private int yylex ()
  {
    int yyl_return = -1;

    try
    {
       yylval = new Object();
       yyl_return = lexer.yylex();
    }
    catch (IOException e)
    {
       System.err.println("error de E/S:"+e);
    }

    return yyl_return;
  }

  /** invocada cuando se produce un error
  **/
  public void yyerror (String descripcion, int yystate, int token)
  {
     System.err.println ("Error en línea "+Integer.toString(lexer.lineaActual())+" : "+descripcion);
     System.err.println ("Token leído : "+yyname[token]);
  }

  public void yyerror (String descripcion)
  {
     System.err.println ("Error en línea "+Integer.toString(lexer.lineaActual())+" : "+descripcion);
     //System.err.println ("Token leido : "+yyname[token]);
  }
