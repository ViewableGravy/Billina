class Stack<T> {
  ArrayList<T> list;
  public Stack() {list = new ArrayList<T>();}
  public void push(T node) {
    list.add(node);
  }
  public T pop() {
   if (list.size()==0)
     throw new IllegalStateException("Stack is empty");
   return list.remove(list.size()-1);
  }
  public boolean contains(T node) {
    return list.contains(node);
  }
  public int size() {
    return list.size();
  }
  
  public T Last() {
   return list.get(list.size() - 1); 
  }
}
