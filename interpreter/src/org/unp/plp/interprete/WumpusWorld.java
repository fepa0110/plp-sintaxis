package org.unp.plp.interprete;

public class WumpusWorld {
	
	// Aquí va el código del mundo
	public boolean[][] pozos;

	public int gold_fila, gold_columna;
	public int wumpus_fila, wumpus_columna;

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
		}
	}

	public void putPit(Coordenada posicion){
		pozos[posicion.fila-1][posicion.columna-1] = true;
	}

	public void putGold(Coordenada posicion){
		this.gold_fila=posicion.fila-1;
		this.gold_columna=posicion.columna-1;
	}

	public void putWumpus(Coordenada posicion){
		this.wumpus_fila=posicion.fila-1;
		this.wumpus_columna=posicion.columna-1;
	}
}
