import java.io.*;
import java.util.*;
public class Main {
    static int N;
    static ArrayList<Integer>[] child;
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        N = Integer.parseInt(br.readLine());
        StringTokenizer st = new StringTokenizer(br.readLine());
        child = new ArrayList[N];
        st.nextToken();
        for (int i = 0; i < N; i++) {
            child[i] = new ArrayList<>();
        }

        for (int i = 1; i < N; i++) {
            child[Integer.parseInt(st.nextToken())].add(i);
        }
        isv = new int[N];
        Arrays.fill(isv, Integer.MIN_VALUE);
        System.out.println(dp(0));
    }
    static int[] isv;
    static int dp(int n) {
        if (child[n].size() == 0) return isv[n] = 0;
        isv[n] = child[n].size();
        PriorityQueue<Integer> hubo = new PriorityQueue<>((o1, o2) -> Integer.compare(o2, o1));

        for (int i = 0; i < child[n].size(); i++) {
            int c = dp(child[n].get(i)) + 1;
            hubo.add(c);
        }

        for (int i = 0; i < child[n].size(); i++) {
            isv[n] = Math.max(hubo.poll() + i, isv[n]);
        }

        return isv[n];
    }
}