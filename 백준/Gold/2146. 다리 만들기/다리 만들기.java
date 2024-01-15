import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Stream;

public class Main {
	static int n = 0;
	
	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		n = s.nextInt();
		int[][] li = new int[n][n];
		
		s.nextLine();
		for(int i = 0; i < n; i++) {
			li[i] = Stream.of(s.nextLine().split(" ")).mapToInt(Integer::parseInt).toArray();
		}
		
		int c = 2;
		
		
		for(int i = 0; i < n; i++) {
			for(int j = 0; j < n; j++) {
				if (li[i][j] == 1) {
					color(i, j, li, c);
					c++;
				}
			}
		}
		
//		for(int i = 0; i < n; i++) {
//			for(int j = 0; j < n; j++) {
//				System.out.print(li[i][j] + " ");
//			}
//			System.out.println();
//		}
		int ans = 12345677;
		
		for(int i = 0; i < n; i++) {
			for(int j = 0; j < n; j++) {
				if (li[i][j] != 0) {
					int t = bfs(i, j, li);
					ans = ans > t ? t : ans;
				}
			}
		}
		System.out.println(ans);
	}
	
	public static int bfs(int i, int j, int[][] li) {
		int[] ix = {0, 0, 1, -1};
		int[] iy = {1, -1, 0, 0};
		
		List<PPair> q = new ArrayList<>();
		PPair s = new PPair(i, j, 0);
		q.add(s);
		boolean[][] isv = new boolean[n][n];
		
		for (boolean a[]:isv) {
			Arrays.fill(a, false);
		}
		isv[i][j] = true;
		
		while (!q.isEmpty()) {
			PPair t = q.remove(0);
			
			for(int k = 0; k < 4; k++) {
				int x = t.x + ix[k];
				int y = t.y + iy[k];
				if (x < 0 || y < 0 || x >= n || y >= n || isv[x][y] || li[x][y] == li[i][j]) { continue; }
				isv[x][y] = true;
				if (li[x][y] != 0) {
					return t.k;
				}
				
				q.add(new PPair(x, y, t.k + 1));
			}
		}
		
		
		return 12345678;
	}
	
	public static void color(int i, int j, int[][] li, int c) {
		int[] ix = {0, 0, 1, -1};
		int[] iy = {1, -1, 0, 0};
		
		List<Pair> q = new ArrayList<>();
		Pair s = new Pair(i, j);
		q.add(s);
		li[i][j] = c;
		while (q.size() != 0) {
			Pair t = q.remove(0);
			
			for(int k = 0; k < 4; k++) {
				int x = t.x + ix[k];
				int y = t.y + iy[k];
				if (x < 0 || y < 0 || x >= n || y >= n || li[x][y] == 0 || li[x][y] >= 2) { continue; }
				q.add(new Pair(x, y));
				li[x][y] = c;
			}
		}
	}
	
	static class Pair {
		int x;
		int y;
		
		Pair(int x, int y) {
			this.x = x;
			this.y = y;
		}
	}
	
	static class PPair {
		int x;
		int y;
		int k;
		PPair(int x, int y, int k) {
			this.x = x;
			this.y = y;
			this.k = k;
		}
	}
}
/*
2
1 0
0 1
 */
