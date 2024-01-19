import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.Arrays;
import java.util.StringTokenizer;


public class Main {
	static class ST {
		int n;
		int[] st;
		int[] li;
		int m;
		ST(int[] li) { 
			this.li = li;
			this.n = li.length;
			st = new int[4*n];
			Arrays.fill(st, 1);
			m = 4*n;
			make(0, li.length-1, 1);
		}

		int make(int i, int j, int x) {
			if (i == j) { 
				return st[x] = li[i];
			}
			int m = (i + j) / 2;
			return st[x] = make(i, m, x*2) * make(m+1, j, x*2+1);
		}
		int get(int i, int j, int x, int a, int b) {
			if (i > b || j < a) { return 1; }
			if (a <= i && b >= j) { return st[x]; }
			int m = (i + j) / 2;
			return get(i, m, x*2, a, b) * get(m+1, j, x*2+1, a, b);
		}
		int update(int i, int j, int x, int diff, int a) {
			if (a < i || a > j) { return st[x]; }
		
			if (i == j) { 
				return st[x] = diff; 
			}
			int m = (i + j) / 2;
			return st[x] = update(i, m, x*2, diff, a) * update(m+1, j, x*2+1, diff, a);
		}
		void print() {
			for(int i = 0; i < st.length; i++) {
				System.out.print(st[i] + " ");
			}
			System.out.println();
		}
	}
	public static void main(String[] args) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(System.out));
		StringTokenizer st;
		String nk;

		while ((nk = br.readLine()) != null) {
			st = new StringTokenizer(nk);
			int n = Integer.parseInt(st.nextToken());
			int k = Integer.parseInt(st.nextToken());
			int[] li = new int[n];

			st = new StringTokenizer(br.readLine());
			for(int i = 0; i < n; i++) {
				int m = Integer.parseInt(st.nextToken());
				li[i] = (m <= 0) ? ((m == 0) ? 0 : -1) : 1;
			}
			ST seg = new ST(li);
			for(int i = 0; i < k; i++) {
				st = new StringTokenizer(br.readLine());
				if (st.nextToken().equals("P")) {
					int x = Integer.parseInt(st.nextToken())-1;
					int y = Integer.parseInt(st.nextToken())-1;
					switch (seg.get(0, n-1, 1, x, y) ) {
						case -1:
							bw.write("-");
							break;
						case 0:
							bw.write("0");
							break;
						case 1:
							bw.write("+");
							break;
					}
				} else {
					int x = Integer.parseInt(st.nextToken())-1;
					int m = Integer.parseInt(st.nextToken());
					int y = (m <= 0) ? ((m == 0) ? 0 : -1) : 1; 

					seg.update(0, n-1, 1, y, x);
				}
			}

			bw.newLine();
			bw.flush();
		}
		bw.close();
	}
}
/*
 * 
 * 
4 6
-2 6 0 -1
C 1 10
 */