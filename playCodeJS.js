
var synth;
var now;

window.onload = function() {
  var context = new AudioContext();
  // Setup all nodes
  // ...
}

// One-liner to resume playback when user interacted with the page.
document.querySelector('button').addEventListener('click', function() {
  context.resume().then(() => {
    console.log('Playback resumed successfully');
  });
});

function DengenOn(){

//シンセ生成
synth = new Tone.PolySynth().toDestination();
}

function test1(){

const now = Tone.now();

var C_chord = ['C4', 'E4', 'G4'];

//ドが8分音符の長さ鳴る
synth.triggerAttackRelease(C_chord, '16n', now);


}

let input1 = document.getElementById('ChordListFileSelect');
let reader1 = new FileReader();
var ChordListFileText1

input1.addEventListener('change', () => {
    for(file of input1.files){
        //Fileオブジェクト(テキストファイル)のファイル内容を読み込む
        reader1.readAsText(file, 'UTF-8');
        //ファイルの読み込み完了後に内容をコンソールに出力する
        reader1.onload = ()=> {
            ChordListFileText1 = reader1.result;
            ChordListFileText1 = ChordListFileText1.split(/\n/);
        };
    }
});

let input2 = document.getElementById('NoteListFileSelect');
let reader2 = new FileReader();
var NoteListFileText1

input2.addEventListener('change', () => {
    for(file of input2.files){
        //Fileオブジェクト(テキストファイル)のファイル内容を読み込む
        reader2.readAsText(file, 'UTF-8');
        //ファイルの読み込み完了後に内容をコンソールに出力する
        reader2.onload = ()=> {
            NoteListFileText1 = reader2.result;
            NoteListFileText1 = NoteListFileText1.split(/\n/);
        };
    }
});

var ChordList = new Object();
var noteIndex = 0;
function setChordList(){

	for(var i=0; i<ChordListFileText1.length; i++){
		line = ChordListFileText1[i];
		vals = line.split(',');
		
		var array1 = []
		for(var j=1; j<vals.length; j++){
			vals[j] = vals[j].replace("s", "#")
			vals[j] = vals[j].replace("\r", "")
			array1.push(vals[j]);
		}
		
		ChordList[vals[0]] = array1
	}
}
function ShowCurrentNoteSpan(){
	span1 = document.getElementById("CurrentNoteSpan");
	
	note1 = NoteListFileText1[noteIndex]
	note1 = note1.replace("flat", "♭");
	note1 = note1.replace("sharp", "#");
	span1.innerHTML = note1

	
}

function ShowNextNoteSpan(){
	span1 = document.getElementById("NextNoteSpan");
	
	nextNoteIndex = noteIndex + 1
	if(nextNoteIndex == NoteListFileText1.length){
		nextNoteIndex = 0;
	}
	
	note1 = NoteListFileText1[nextNoteIndex]
	note1 = note1.replace("flat", "♭");
	note1 = note1.replace("sharp", "#");
	span1.innerHTML = note1

}
function InitNote(){
	noteIndex=0;
	
	ShowCurrentNoteSpan();
	ShowNextNoteSpan();
}

function OutputSound(chordName, soundLength){
	const now2 = Tone.now();
	chordVal = ChordList[chordName];
	
	synth.triggerAttackRelease(chordVal, soundLength, now2);
	
}

function Play1(){

	note = NoteListFileText1[noteIndex];
	note = note.replace('\r', '')
	OutputSound(note, '8n')
	
	if(noteIndex+1 == NoteListFileText1.length){
		noteIndex = 0;
	}else{
		noteIndex = noteIndex + 1
	}
	
	ShowCurrentNoteSpan();
	ShowNextNoteSpan();
	
}

function ToPrev(){
	if(noteIndex >= 1){
		noteIndex = noteIndex-1;
	}

	ShowCurrentNoteSpan();
	ShowNextNoteSpan();
}
