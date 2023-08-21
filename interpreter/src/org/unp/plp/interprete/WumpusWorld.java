package org.unp.plp.interprete;

public class WumpusWorld {
	
	// Aquí va el código del mundo
	public boolean[][] pozos;

	public int gold_fila, gold_columna;
	public int wumpus_fila, wumpus_columna;
	public int hero_fila, hero_columna;

	public void create(int filas, int columnas){
		pozos = new boolean[filas][columnas];
	}

	public void putElement(String element, Coordenada posicion){
		switch(element){
			case "pit": putPit(posicion);
			break;

			case "gold": putGold(posicion);
			break;

			case "wumpus": putWumpus(posicion);
			break;

			case "hero": putHero(posicion);
			break;
		}
	}

	public void putPit(Coordenada posicion){
		pozos[posicion.fila][posicion.columna] = true;
	}

	public void putGold(Coordenada posicion){
		this.gold_fila=posicion.fila;
		this.gold_columna=posicion.columna;
	}

	public void putWumpus(Coordenada posicion){
		this.wumpus_fila=posicion.fila;
		this.wumpus_columna=posicion.columna;
	}

	public void putHero(Coordenada posicion){
		this.hero_fila=posicion.fila;
		this.hero_columna=posicion.columna;
	}

	public void printWorld(){
		System.out.print("   |");
		for(int columna = 0; columna<=this.pozos[0].length-1; columna++){
			//Columnas
			System.out.print(" "+columna+" |");
		}
		System.out.println();

		for (int fila = 0; fila <= this.pozos.length-1; fila++){
			System.out.print(" "+fila+" |");
			
			for(int columna = 0; columna<=this.pozos[fila].length-1; columna++){
				if(fila==this.gold_fila && columna == this.gold_columna){
					System.out.print(" G |");
				}
				else if (fila==this.wumpus_fila && columna == this.wumpus_columna) {
					System.out.print(" W |");
				}
				else if (fila==this.hero_fila && columna == this.hero_columna) {
					System.out.print(" H |");
				}
				else if(!pozos[fila][columna]){
					System.out.print("   |");
				}
				else{
					System.out.print(" P |");
				}
			}
			System.out.println();
		}
	}
}
