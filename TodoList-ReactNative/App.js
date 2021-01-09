/* eslint-disable prettier/prettier */
import React, {useState} from 'react';
import {View, Alert ,StyleSheet, FlatList} from 'react-native';
import {v4 as uuidv4} from 'uuid';
import Header from './components/Header';
import ListItem from './components/ListItem';
import AddItem from './components/AddItem';

const App = () => {
  const [items, setItems] = useState([
    {id: uuidv4(), text: 'Create a new App'},
    {id: uuidv4(), text: 'Start the App'},
    {id: uuidv4(), text: 'Complete the App'},
    {id: uuidv4(), text: 'Test the App'},
    {id: uuidv4(), text: 'Publish the App'},

  ]);

  const deleteItem = (id) => {
    setItems(prevItems => {
      // eslint-disable-next-line eqeqeq
      return prevItems.filter(item => item.id != id);
    });
  };

  const addItem = (text) => {
    if (!text){
     Alert.alert('Error', 'Please enter an item', [{text:'Ok'}]);
    }
    else {
      setItems(prevItems => {
        return [...prevItems,{id:uuidv4(), text}];
      });
    }
    
  };

  return (
    <View style={styles.container}>
      <Header title="TodoList" />
      <AddItem addItem={addItem} />
      <FlatList
      data={items}
  renderItem={({item}) => <ListItem item={item} deleteItem={deleteItem} /> } />
  </View>

  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default App;
