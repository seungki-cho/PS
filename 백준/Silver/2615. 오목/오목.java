import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.StringTokenizer;

public class Main {
	

	public static void main(String[] args) throws Exception {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		int[][] li = new int[19][19];
		for(int i = 0; i < 19; i++) {
			String[] line = br.readLine().split(" ");
			for(int j = 0; j < 19; j++) {
				li[i][j] = Integer.parseInt(line[j]);
			}
		}
		
		int[] dxs = {1, 0, -1, 1};
		int[] dys = {1, 1, 1, 0};
		for(int i = 0; i < 19; i++) {
			for(int j = 0; j < 19; j++) {
				if(li[i][j] == 0) continue;
				for(int k = 0; k < dxs.length; k++) {
					if (find(li, i, j, dxs[k], dys[k])) {
						System.out.println(li[i][j]);
						System.out.println((i+1) + " " + (j+1));
						return;
					}
				}
			}
		}
		System.out.println(0);
	}
	
	public static boolean find(int[][] li, int x, int y, int dx, int dy) {
		int isBlack = li[x][y];
		boolean isFail = false;
		
		for(int i = 1; i < 5; i++) {
			int X = x + dx*i;
			int Y = y + dy*i;
			if (isOut(X, Y)) return false;
			if (isBlack != li[X][Y]) return false;
		}
		
		if(!isOut(x - dx, y - dy)) {
			if(isBlack == li[x-dx][y-dy]) return false;
		}
		if(!isOut(x + dx*5, y + dy*5)) {
			if(isBlack == li[x+dx*5][y+dy*5]) return false;
		}
		
		return true;
	}
	
	public static boolean isOut(int x, int y) {
		return x < 0 || y < 0 || x >= 19 || y >= 19;
	}
}