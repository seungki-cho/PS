import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Array;
import java.util.*;

public class Main {
    static int L;
    static int C;
    static char[] li;
    static ArrayList<Character> tmp = new ArrayList<>();
    static StringBuilder sb = new StringBuilder();
    static void find(int n) {
        if (tmp.size() == L) {
            int ahdmarotn = tmp.stream().map(e -> is(e) ? 1 : 0).reduce(Integer::sum).get();
            int wkdmarotn = tmp.size() - ahdmarotn;

            if (ahdmarotn > 0 && wkdmarotn >= 2) {
                for(int i = 0; i < L; i++) {
                    System.out.print(tmp.get(i));
                }
                System.out.println();
            }
            return;
        }
        if (n == C) { return; }

        tmp.add(li[n]);
        find(n+1);
        tmp.remove(tmp.size() - 1);
        find(n+1);
    }
    static boolean is(char a) {
        return a == 'i' || a == 'e' || a == 'o' || a == 'u' || a == 'a';
    }
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        StringBuilder sb = new StringBuilder();
        L = Integer.parseInt(st.nextToken());
        C = Integer.parseInt(st.nextToken());
        st = new StringTokenizer(br.readLine());
        li = new char[C];
        for(int i = 0; i < C; i++){
            li[i] = st.nextToken().toCharArray()[0];
        }
        Arrays.sort(li);
        find(0);
        System.out.println(sb);
    }
}