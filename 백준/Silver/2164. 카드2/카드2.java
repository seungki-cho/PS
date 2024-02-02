import java.io.*;
import java.util.*;

public class Main {
    static class Queue<T> {
        private LinkedList<T> q = new LinkedList<>();

        int size() {
            return q.size();
        }
        void enqueue(T t) {
            q.addLast(t);
        }
        T dequeue() {
            return q.removeFirst();
        }
    }
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        Queue<Integer> q = new Queue<>();

        for (int i = 1; i <= N; i++) {
            q.enqueue(i);
        }
        while (q.size() != 1) {
            q.dequeue();
            q.enqueue(q.dequeue());
        }
        System.out.println(q.dequeue());
    }
}
// asdfasdfasdasdfasdfasd