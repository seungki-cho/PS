import java.util.*;
import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        char[] text = br.readLine().toCharArray();
        char[] pattern = br.readLine().toCharArray();
        int N = text.length;
        int M = pattern.length;

        int[] pi = new int[M];
        int j = 0;

        for (int i = 1; i < M; i++) {
            while (j > 0 && pattern[i] != pattern[j])
                j = pi[j-1];

            if (pattern[i] == pattern[j]){
                pi[i] = ++j;
            }
        }
        ArrayList<Integer> ans = new ArrayList<>();
        for (int i = 0; i < N; i++) {
            while (j > 0 && text[i] != pattern[j])
                j = pi[j - 1];
            if (text[i] == pattern[j]) {
                if (j == M-1) {
                    if (i - M + 1 >= 0) {
                        ans.add(i - M + 1);
                    }
                    j = pi[j];
                } else {
                    j++;
                }
            }
        }
        StringBuilder sb = new StringBuilder();
        sb.append(ans.size() + "\n");
        for (int i = 0; i < ans.size(); i++) {
            sb.append((ans.get(i)+1) + " ");
        }
        System.out.println(sb);
    }
}

/*
ababababcababaca
ababaca
 */