import java.util.ArrayList;
import java.util.Arrays;
import java.util.PriorityQueue;
import java.util.Scanner;

public class Main {
	static boolean[][] isv;
	static int n;
	static int m;
	static int c = 0;
	public static class Aw implements Comparable<Aw>{
		int a;
		int w;
		Aw(int a, int w) {
			this.a = a;
			this.w = w;
		}

		@Override
		public int compareTo(Aw to) {
			return this.w < to.w ? -1 : 1;
		}
	}
	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);	
		n = s.nextInt();  
		m = s.nextInt();
		s.nextLine();

		String[] women = s.nextLine().split(" ");
		isv = new boolean[n][m];
		ArrayList<ArrayList<Aw>> adj = new ArrayList();

		for(int i = 0; i < n; i++) {
			adj.add(new ArrayList<Aw>());
		}

		for(int i = 0; i < m; i++) {
			int a = s.nextInt()-1;
			int b = s.nextInt()-1;
			int w = s.nextInt();
			
			if (women[a].equals(women[b])) { continue; }
			adj.get(a).add(new Aw(b, w));
			adj.get(b).add(new Aw(a, w));
		}
		PriorityQueue<Aw> heap = new PriorityQueue<>();
		
		heap.add(new Aw(0, 0));
		boolean[] isv = new boolean[n];
		ArrayList<Aw> aws = new ArrayList<>();

		while (aws.size() < n && heap.size() > 0) {
			Aw from = heap.poll();

			if (isv[from.a]) { continue; }
			isv[from.a] = true;
			aws.add(from);
			for(Aw to: adj.get(from.a)) {
				if (!isv[to.a]) {
					heap.add(new Aw(to.a, to.w));
				}
			}
 		}
		
		for(int i = 0; i < n; i++) {
			if (!isv[i]) {
				System.out.println("-1");
				return;
			}
		}

		int ans = aws.stream()
					.map(a -> a.w)
					.reduce((a, b) -> { return a+b; })
					.get();
		System.out.println(ans);
	}
	public static void printaa(String[][] li, int n, int m) {
		for(int i = 0; i < n; i++) {
			for(int j = 0; j < m; j++) {
				System.out.print(li[i][j]);
			}
			System.out.println();
		}
	}
}