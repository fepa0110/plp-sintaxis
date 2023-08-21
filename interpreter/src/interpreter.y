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
%token ELEMENT
%token PRINT
%token START

%token PUT
%token IN

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
  : operation_statement NL
  | print_world_statement NL
  | start_statement NL
  | NL
  ;

world_statement
  : WORLD CONSTANT 'x' CONSTANT { world.create((int)$2, (int)$4); }
  ;

operation_statement 
  : PUT ELEMENT IN coord { world.putElement((String)$2, (Coordenada)$4); }
  ;

print_world_statement
  : PRINT WORLD { world.printWorld(); }
  ;

start_statement
  : START { System.out.println("Iniciando..."); }
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
