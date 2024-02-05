import java.io.*;
import java.util.*;

public class Main {
    static class Stack<T> {
        private LinkedList<T> q = new LinkedList<>();

        int size() {
            return q.size();
        }
        void push(T t) {
            q.addLast(t);
        }
        T pop() {
            return q.removeLast();
        }
        void removeAll() {
            q = new LinkedList<>();
        }

        T peek() { return q.getLast(); }

        @Override
        public String toString() {
            StringBuilder sb = new StringBuilder();
            for(int i =0 ; i < q.size(); i++ ){
                sb.append(q.get(i).toString() + " ");
            }
            return sb.toString();
        }

        public void print() {
            StringBuilder sb = new StringBuilder();
            for(int i =0 ; i < q.size(); i++ ){
                sb.append(q.get(i).toString() + " ");
            }
            System.out.println(sb.toString());
        }
    }
    static class Pair {
        int height;
        int index;
        Pair(int height, int index) {
            this.height = height;
            this.index = index;
        }

        @Override
        public String toString() {
            return height + " " + index;
        }
    }
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        int N = Integer.parseInt(br.readLine());
        Stack<Pair> stack = new Stack<>();
        StringTokenizer st = new StringTokenizer(br.readLine());
        StringBuilder sb = new StringBuilder();

        for(int i = 0; i < N; i++) {
            int n = Integer.parseInt(st.nextToken());
            if (stack.size() == 0 || stack.peek().height < n) {
                while (!(stack.size() == 0 || stack.peek().height >= n)) {
                    stack.pop();
                }
                if (stack.size() == 0) {
                    sb.append(0).append(" ");
                } else {
                    sb.append(stack.peek().index+1 + " ");
                }
                
                stack.push(new Pair(n, i));
            } else {
                sb.append(stack.peek().index+1).append(" ");
                stack.push(new Pair(n, i));
            }
        }

        System.out.println(sb.toString());


    }
}