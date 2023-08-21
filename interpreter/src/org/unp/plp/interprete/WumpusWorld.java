package org.unp.plp.interprete;

public class WumpusWorld {
	
	// Aquí va el código del mundo
	public boolean[][] pozos;

	public void create(int filas, int columnas){
		pozos = new boolean[filas][columnas];
	}

	public void putPit(Coordenada coordenada){
		pozos[coordenada.fila][coordenada.columna] = true;
	}
}
