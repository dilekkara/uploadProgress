<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Upload</title>
   <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

   <section>
      <form action="FileSource" autocomplete= "off" enctype="multipart/form-data" method="post">
         <p>Upload File</p>
         
         <div>
            <input type="file" id="upload" name= "file" style="display: none;" multiple>
            <label for="upload">Select Files</label>
         
         </div>
         
         <button ><span>&#8682; Upload</span> <span class="uploading">Uploading...</span></button>
         <button class="cancle">Cancle Upload</button>
         
         <div class="pr">
            <strong>
            <h4 class="ex">PDF</h4>
            <h5 class="size">2.5kb</h5>
            </strong>
            <progress min="0" max="100" value="0"></progress></br>
            <span class="progress-indicator"></span>
         
         </div>
        
      
      </form>
     
   </section>
   
  



<script>

let file = document.getElementById('upload');
let button = document.getElementsByTagName('button');
let progress = document.querySelector('progress');
let p_i = document.querySelector('.progress-indicator');
let load = 0;
let proces = "";

file.oninput = ()=> {
	let filename = file.files[0].name;
	let extension = filename.split('.').pop();
	let filesize = file.files[0].size;
	
	if(filesize <= 1000000){
		filesize = (filesize/100).toFixed(2) +'kb';
	
	}
	if (filesize == 1000000 || filesize <= 1000000000){
		filesize = (filesize/1000000).toFixed(2) + 'mb';
	}
	if(filesize == 1000000000 || filesize <= 1000000000000){
		filesize = (filesize/1000000000).toFixed(2) + 'mb';
	}
	
	document.querySelector('label').innerText = filename;
	document.querySelector('.ex').innerText = extension;
	document.querySelector('.size').innerText = filesize;
	getFile(filename)
}
let upload = ()=>{
	
	if (load >= 100){
		clearInterval(proces);
		p_i.innerHTML ='100%' + '' + 'Upload Complated!';
		alert("Yükleme başarılı!")
		upoloadFile();
		
		button[0].classList.remove('active');
		
	
	}
	else {
		load++;
		progress.value = load;
		p_i.innerHTML = load + '%' + '' + 'Upload';
		button[1].onclick = e=>{
			e.preventDefault();
			clearInterval(proces);
			documnet.querySelector('.pr').style.display = "none";
			button[1].style.visibility = 'hidden';
			button[0].classList.remove('active');
		}
	}
	
}
function getFile(fileName){
		
		if(fileName){
			document.querySelector('.pr').style.display = "block";
			load = 0;
			progress.value = 0;
			p_i.innerText = '';
			button[0].onclick = e => {
				e.preventDefault();
				button[0].classList.add('active');
				button[1].style.visibility = 'visible';
				proces = setInterval(upload, 100);
				
				
				
				
				
				
			}
			
	}
}

function upoloadFile() {
    let file = document.getElementById('upload').files[0];
    let formData = new FormData();
    formData.append('file', file);

    fetch('FileSource', {
        method: 'POST',
        body: formData
    }).then(response => {
        if (response.ok) {
            return response.text();
        }
        throw new Error('Network response was not ok.');
    }).then(text => {
        alert(text);
    }).catch(error => {
        console.error('There was a problem with your fetch operation:', error);
    });
}








</script>

</body>
</html>
