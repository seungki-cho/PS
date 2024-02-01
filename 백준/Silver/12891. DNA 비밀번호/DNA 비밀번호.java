import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.PriorityQueue;
import java.util.StringTokenizer;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int S = Integer.parseInt(st.nextToken());
        int P = Integer.parseInt(st.nextToken());
        String[] s = br.readLine().split("");
        st = new StringTokenizer(br.readLine());
        int[] acgt = new int[] { Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken())};
        int[] cur = new int[4];

        for(int i = 0; i < P; i++) {
            switch (s[i]) {
                case "A":
                    cur[0] += 1;
                    break;
                case "C":
                    cur[1] += 1;
                    break;
                case "G":
                    cur[2] += 1;
                    break;
                case "T":
                    cur[3] += 1;
                    break;
            }
        }
        int ans = 0;
        for(int i = P; i < S+1; i++) {
            boolean isS = true;
            for(int j = 0; j < acgt.length; j++) {
                if (acgt[j] > cur[j]) {
                    isS = false;
                }
            }
            if (isS) { ans++; }
            if (i == S) { break; }
            switch (s[i]) {
                case "A":
                    cur[0] += 1;break;
                case "C":
                    cur[1] += 1;break;
                case "G":
                    cur[2] += 1;break;
                case "T":
                    cur[3] += 1;break;
            }
            switch (s[i-P]) {
                case "A":
                    cur[0] -= 1;break;
                case "C":
                    cur[1] -= 1;break;
                case "G":
                    cur[2] -= 1;break;
                case "T":
                    cur[3] -= 1;break;
            }
        }
        System.out.println(ans);
    }
}
/*

4 3
1 2 3 4
2 3 4 5
3 4 5 6
4 5 6 7
2 2 3 4
3 4 3 4
1 1 4 4


 */