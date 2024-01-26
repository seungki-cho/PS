// Online Java Compiler
// Use this editor to write, compile and run your Java code online
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int[] li = new int[N];
        
        st = new StringTokenizer(br.readLine());
        for(int i = 0; i < N; i++) {
            li[i] = Integer.parseInt(st.nextToken());
        }
        if (N == 1) { System.out.println("A"); return; }
        if (N == 2) { System.out.println(li[0] != li[1] ? "A" : li[0]); return; }

        int a = (li[1] - li[0] == 0) ? 0 : ((li[2] - li[1]) / (li[1] - li[0]));
        int b = li[1] - li[0] * a;
        for(int i = 1; i < N; i++) {
            if (li[i-1] * a + b != li[i]) { System.out.println("B"); return; }
        }
        System.out.println(li[N-1] * a + b);
    }
}