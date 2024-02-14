import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    static ArrayList<Integer> uf;
    static HashMap<String, Integer> n2i;

    static int find(int n) {
        if (uf.get(n) < 0) {
            return n;
        }
        uf.set(n, find(uf.get(n)));
        return uf.get(n);
    }
    static void merge(int a, int b) {
        int A = find(a);
        int B = find(b);

        if (A != B) {
            uf.set(A, uf.get(B) + uf.get(A));
            uf.set(B, A);
        }
    }
    static int print(int a, int b){
        return Math.min(uf.get(find(a)), uf.get(find(b))) * -1;
    }

    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int T = Integer.parseInt(st.nextToken());
        StringBuilder sb = new StringBuilder();
        for(int t = 0; t < T; t++) {
            int F = Integer.parseInt(br.readLine());
            uf = new ArrayList<>();
            n2i = new HashMap<>();

            for(int f = 0; f < F; f++) {
                String[] fs = br.readLine().split(" ");
                String a = fs[0];
                String b = fs[1];

                if (!n2i.containsKey(a)){
                    uf.add(-1);
                    n2i.put(a, uf.size()-1);
                }
                if (!n2i.containsKey(b)) {
                    uf.add(-1);
                    n2i.put(b, uf.size()-1);
                }
                int x = n2i.getOrDefault(a, 0);
                int y = n2i.getOrDefault(b, 0);
                merge(x, y);
                sb.append(print(x, y)).append("\n");
            }
        }
        System.out.println(sb);
    }
}