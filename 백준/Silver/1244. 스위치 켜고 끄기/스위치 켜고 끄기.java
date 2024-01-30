import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.StringTokenizer;

public class Main {
    static int N;
    static int[] sws;

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        N = Integer.parseInt(st.nextToken());
        sws = new int[N];
        st = new StringTokenizer(br.readLine());
        for(int i = 0; i < N; i++) {
            sws[i] = Integer.parseInt(st.nextToken());
        }

        int M = Integer.parseInt(br.readLine());

        for(int i = 0; i < M; i++){
            st = new StringTokenizer(br.readLine());
            int oneIsMale = Integer.parseInt(st.nextToken());
            int n = Integer.parseInt(st.nextToken());

            if (oneIsMale == 1) {
                male(n); 
            } else {
                female(n);
            }
        }
        
        StringBuilder sb = new StringBuilder();
        for(int i = 0; i < N; i++) {
            sb.append(sws[i] + " ");
            if ((i+1) % 20 == 0) { sb.append("\n"); }
        }
        System.out.println(sb.toString());
    }

    public static void male(int n) {
        for(int i = 0; i < N; i++) {
            if ((i+1) % n != 0) { continue; }
            sws[i] = (sws[i] + 1) % 2;
        }
    }

    public static void female(int n) {
        int pa = n-1;
        int pb = n-1;
        while (pa >= 0 && pb < N) {
            if (sws[pa] == sws[pb]) {
                sws[pa] = (sws[pa] + 1) % 2;
                if (pa != pb) {
                sws[pb] = (sws[pb] + 1) % 2;
                }
                pa -= 1;
                pb += 1;
                continue;
            } else {
                break;
            }
        }
    }
}