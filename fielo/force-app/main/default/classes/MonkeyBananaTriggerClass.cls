public class MonkeyBananaTriggerClass {

     // +++++++++++++++++++++  Inner Classes  ++++++++++++++++++++++++++++++ //
     // +++++++++++++++++++++  ClassVariables  ++++++++++++++++++++++++++++++ //
     public static List<List<integer>> matrix = new List<List<Integer>>();
     public static Integer numLines = 0;
     public static Integer numRows = 0;
     public static map<integer,integer> res = new map<integer,integer>();
     public static List<Monkey_Banana__c> MBT = new List<Monkey_Banana__c>();
     // +++++++++++++++++++++  Attributes/Getter-Setter  ++++++++++++++++++++++++++++++ //
     // +++++++++++++++++++++  Constructor    ++++++++++++++++++++++++++++++ //
     // +++++++++++++++++++++  Methods    ++++++++++++++++++++++++++++++ //
    
    
    
     public MonkeyBananaTriggerClass(List<Monkey_Banana__c> triggerNew) {
        
        numLines = (Integer)triggerNew[0].numberLine__c	;
        numRows  = (Integer)triggerNew[0].numberRow__c	;
         integer randomNumber = 0;
         String s = '';
		MBT = triggerNew;
         
        system.debug('###NUMLINES =' +  numLines);
        system.debug('###numRows =' +  numRows);
        for(integer i = 0; i < numLines; ++i){
            list<Integer> lstRow = new List<integer>();
            res.put(i,0);
            for(integer j = 0; j < numRows; ++j){
                randomNumber = (Math.random()*100).intValue();
                lstRow.add(randomNumber);
                s += randomNumber + ',';
            }
            matrix.add(lstRow);
            s += '///';
        }
         system.debug('###MATRIX = ' +  matrix);
         system.debug('### s = ' + s);
         MBT[0].Matrix__c = s;
     }
    
   
     public Integer bestPath() {
        
         // Get max score from each start line
         for(integer i = 0; i< numLines; i++){
             system.debug('###start calcul path  = ' +  i);
             nextBestPath(i,i,0);
         }
         MBT[0].bestResult__c = max(res.values());
         return max(res.values());
     }        
             
     public integer nextBestPath(integer startpoint,integer line, integer row){
        system.debug('###position = ' +  line + ',' + row);
		system.debug('###value = ' +  matrix[line][row]);
         system.debug('###current value = ' +  res.get(startpoint));
         res.put(startpoint,res.get(startpoint)+matrix[line][row]);
         // OPTION 1 TOP OF MATRIX && not at the right border
         if(line == 0 && row < numRows-1){
             System.debug('### OPTION 1');
             if(matrix[line][row+1] > matrix[line+1][row+1])
               	 return nextBestPath(startpoint,line,row+1); 
             else
                 return nextBestPath(startpoint,line+1,row+1);
         }
		 // OPTION 2 BOTTOM OF MATRIX         
		 if(line == numLines-1 && row < numRows-1){
            System.debug('### OPTION 2');

             if(matrix[line][row+1] > matrix[line-1][row+1])
               	 return nextBestPath(startpoint,line,row+1); 
             else
                 return nextBestPath(startpoint,line-1,row+1); 
        }
        // OPTION 3 MIDDLE OF MATRIX
        if(row < numRows-1){
           System.debug('### OPTION 3');

             if(matrix[line][row+1] > matrix[line-1][row+1] && matrix[line][row+1] > matrix[line+1][row+1])
               	 return nextBestPath(startpoint,line,row+1);
             else if(matrix[line][row+1] < matrix[line-1][row+1] && matrix[line-1][row+1] > matrix[line+1][row+1])
                 return nextBestPath(startpoint,line-1,row+1); 
             else 
            	return nextBestPath(startpoint,line+1,row+1);
        }
        return matrix[line][row];
     }           
    
    // Return max value of a list
    public integer max(list<integer> lstINT){
     system.debug('###start max  = ' +  lstINT);
    Integer maxvalue = 0;
        For (integer i =0;i<lstINT.size();i++)
        {            
            if( lstINT[i] > maxvalue)
                maxvalue = lstINT[i];             
        }    
		 return maxvalue;
     }
}