import java.util.Arrays;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

public class Main {
	static boolean[][] isv;
	static int n;
	static int m;
	static int c = 0;
	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		n = s.nextInt();  
		m = s.nextInt();
		
		isv = new boolean[n][m];
		s.nextLine();
		Set<String> set = new HashSet();
 
		String[][] li = new String[n][m];
		for(int i = 0; i < n; i++) {
			li[i] = s.nextLine().split("");
		}
		
		for(int i = 0; i < n; i++) {
			for(int j = 0; j < m; j++) {
				if ("LRUD".contains(li[i][j]) && !isv[i][j]) {
					set.add(dfs(li, i, j));
					// printaa(li);
				}
			}
		}
		System.out.println(set.size());
	}
	public static void printaa(String[][] li) {
		for(int i = 0; i < n; i++) {
			for(int j = 0; j < m; j++) {
				System.out.print(li[i][j]);
			}
			System.out.println();
		}
	}
	public static String dfs(String[][] li, int i, int j) {
		boolean isFail = false;
		if (!"LRUD".contains(li[i][j])) {
			return li[i][j];
		}
		if (isv[i][j]) {
			li[i][j] = String.valueOf(c++);
			return li[i][j];
		}
		
		isv[i][j] = true;
		int I = i;
		int J = j;
		switch (li[i][j]) {
		case "L":
			if (j-1 == -1) { isFail = true; break; }
			j -= 1;
			break;
		case "R":
			if (j+1 == m) { isFail = true; break; }
			j += 1;
			break;
		case "U":
			if (i-1 == -1) { isFail = true; break; }
			i -= 1;
			break;
		case "D":
			if (i+1 == n) { isFail = true; break; } 
			i += 1;
			break;
		}

		if (isFail) {
			li[i][j] = String.valueOf(c++);
			return li[i][j];
		}
		
		li[I][J] = dfs(li, i, j);

		return li[I][J];
	}
}
