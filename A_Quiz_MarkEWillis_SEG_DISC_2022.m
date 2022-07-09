function A_Quiz_MarkEWillis_SEG_DISC_2022


% ***********************************************************************************************************
%  A_Quiz_MarkEWillis_SEG_DISC_2022 - this routine is a quiz about DAS technology
% ***********************************************************************************************************
%
% MIT License
% 
% Copyright (c) 2022 Mark E. Willis
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%
% ***********************************************************************************************************   

global testQuestions

% create the main gui figure

testQuestions.h.fig1 = uifigure('Name','A Quiz - Mark E. Willis SEG DISC DAS Class 2022','Position',[670 200 850 500]);


% *******************************************************
% create the Question field
% *******************************************************

testQuestions.h.text_question = uilabel(testQuestions.h.fig1);
testQuestions.h.text_question.Text = 'Question?';
testQuestions.h.text_question.FontSize = 20;
testQuestions.h.text_question.Position = [22 430 660 50];  

% *******************************************************
% create the button group
% *******************************************************

testQuestions.h.buttongroup = uibuttongroup(testQuestions.h.fig1);
testQuestions.h.buttongroup.Title = 'Please select an answer:';
testQuestions.h.buttongroup.FontSize = 20;
%testQuestions.h.text_question.BackgroundColor = [1 1 1];
testQuestions.h.buttongroup.Position = [28 80 780 325];  
testQuestions.h.buttongroup.SelectionChangedFcn = @bselection;

% *******************************************************
% create radiobutton 1 
% *******************************************************

testQuestions.h.radiobutton_1 = uiradiobutton(testQuestions.h.buttongroup,'Text','Answer 1',...
                                             'Position',[34 248 690 41], ...
                                             'FontSize',16,'Tag','1'); %, ...
                                             %'ButtonPushedFcn', @(hb,event) radioPushed_1(1));

% *******************************************************
% create radiobutton 2 
% *******************************************************

testQuestions.h.radiobutton_2 = uiradiobutton(testQuestions.h.buttongroup,'Text','Answer 2',...
                                             'Position',[34 184 690 41], ...
                                             'FontSize',16,'Tag','2'); %, ...
                                             %'ButtonPushedFcn', @(hb,event) radioPushed_2(2));

% *******************************************************
% create radiobutton 3 
% *******************************************************

testQuestions.h.radiobutton_3 = uiradiobutton(testQuestions.h.buttongroup,'Text','Answer 3',...
                                             'Position',[34 125 690 41], ...
                                             'FontSize',16,'Tag','3'); %, ...
                                             %'ButtonPushedFcn', @(hb,event) radioPushed_3(3));

% *******************************************************
% create radiobutton 4 
% *******************************************************

testQuestions.h.radiobutton_4 = uiradiobutton(testQuestions.h.buttongroup,'Text','Answer 4',...
                                             'Position',[34 55 690 41], ...
                                             'FontSize',16,'Tag','4'); %, ...
                                             %'ButtonPushedFcn', @(hb,event) radioPushed_4(4));

% *******************************************************
% create submit button 
% *******************************************************

testQuestions.h.pushbutton_submit = uibutton(testQuestions.h.fig1,'Text','Submit',...
                                             'Position',[450 17 150 51], ...
                                             'FontSize',16, ...
                                             'ButtonPushedFcn', @(hb,event) buttonPushed_Submit(1));
set(testQuestions.h.pushbutton_submit,'Visible','off')

% *******************************************************
% create Next button 
% *******************************************************

testQuestions.h.pushbutton_next = uibutton(testQuestions.h.fig1,'Text','Next',...
                                             'Position',[650 17 150 51], ...
                                             'FontSize',16, ...
                                             'ButtonPushedFcn', @(hb,event) buttonPushed_Next(4));
set(testQuestions.h.pushbutton_next,'Visible','off')


% *******************************************************
% load in the first set of questions
% *******************************************************

getQuestions
loadNextQuestion

end

function bselection(source,eventdata)

global testQuestions

switch get(eventdata.NewValue,'tag')
    case '1'
        % button one was pressed
    case '2'
        % button two was pressed
    case '3'
        % button three was pressed
    case '4'
        % button three was pressed

end

if ~ testQuestions.noBackup
    % don't allow  guesing twice, though!
    % turn on the submit answer pushbutton
    set(testQuestions.h.pushbutton_submit,'Visible','on')
end

end

function buttonPushed_Next(~)

global testQuestions

loadNextQuestion

testQuestions.noBackup = false;

end


function buttonPushed_Submit(~)

global testQuestions

switch testQuestions.q(testQuestions.currentQuestion).correct
    
    case 1
        correct = get(testQuestions.h.radiobutton_1,'Value');
    case 2
        correct = get(testQuestions.h.radiobutton_2,'Value');
    case 3
        correct = get(testQuestions.h.radiobutton_3,'Value');
    case 4
        correct = get(testQuestions.h.radiobutton_4,'Value');
end


if correct
        set(testQuestions.h.buttongroup,'Title',['Question ' num2str(testQuestions.currentQuestion) ' CORRECT! ' ])
        testQuestions.correct    = testQuestions.correct   + 1;
else
        set(testQuestions.h.buttongroup,'Title',['Question ' num2str(testQuestions.currentQuestion) ' Sorry NOT CORRECT! ' ])
        testQuestions.incorrect  = testQuestions.incorrect + 1;
end    

    % turn on the submit answer pushbutton
    set(testQuestions.h.pushbutton_submit,'Visible','off')
    
     % turn on the submit answer pushbutton
    set(testQuestions.h.pushbutton_next,'Visible','on')
    
    % don't allow more guesing!
    testQuestions.noBackup          = true;


end

function loadNextQuestion(~)

global testQuestions

testQuestions.currentQuestion = testQuestions.currentQuestion + 1;

if testQuestions.currentQuestion > testQuestions.numberOfQuestions
    
    % all done
    % turn off all radiobuttons
    set(testQuestions.h.buttongroup ,'Visible','off')

    % give the stats
    set(testQuestions.h.text_question,'Text',[num2str(testQuestions.correct) ' Correct and ' num2str(testQuestions.incorrect) ' Incorrect'])

    % turn on the submit answer pushbutton
     set(testQuestions.h.pushbutton_submit,'Visible','off')   
    
     % turn on the next answer pushbutton
     set(testQuestions.h.pushbutton_next,'Visible','off')   
    
else
    
    % update the panel title
    set(testQuestions.h.buttongroup,'Title',['Question ' num2str(testQuestions.currentQuestion) ])
    
    % update the question
    set(testQuestions.h.text_question,'Text',char(testQuestions.q(testQuestions.currentQuestion).question))

    % update the four answers
    set(testQuestions.h.radiobutton_1,'Text',char(testQuestions.q(testQuestions.currentQuestion).answer(1)))
    set(testQuestions.h.radiobutton_2,'Text',char(testQuestions.q(testQuestions.currentQuestion).answer(2)))
    set(testQuestions.h.radiobutton_3,'Text',char(testQuestions.q(testQuestions.currentQuestion).answer(3)))
    set(testQuestions.h.radiobutton_4,'Text',char(testQuestions.q(testQuestions.currentQuestion).answer(4)))

    % deselect all the radiobuttons
    set(testQuestions.h.radiobutton_1,'Value',0)
    set(testQuestions.h.radiobutton_2,'Value',0)
    set(testQuestions.h.radiobutton_3,'Value',0)
    set(testQuestions.h.radiobutton_4,'Value',0)
    
    % turn on the submit answer pushbutton
     set(testQuestions.h.pushbutton_submit,'Visible','on')   
    
     % turn on the next answer pushbutton
     set(testQuestions.h.pushbutton_next,'Visible','off')   
end

end

function getQuestions

global testQuestions

testQuestions.currentQuestion   = 0;
testQuestions.numberOfQuestions = 14;
testQuestions.correct           = 0;
testQuestions.incorrect         = 0;

testQuestions.noBackup          = false;


testQuestions.q(1).question = 'What does FIMT stand for?';
testQuestions.q(1).answer{1} = 'Fudge in mint topping';
testQuestions.q(1).answer{2} = 'Frigging important material texture';
testQuestions.q(1).answer{3} = 'Fiber inserted mid-tree';
testQuestions.q(1).answer{4} = 'Fiber in metal tube';
testQuestions.q(1).correct   = 4;


testQuestions.q(2).question = 'What does CMN stand for?';
testQuestions.q(2).answer{1} = 'Chocolate mint nougat';
testQuestions.q(2).answer{2} = 'Charcoal metal ';
testQuestions.q(2).answer{3} = 'Common mode noise';
testQuestions.q(2).answer{4} = 'Coherent multi-node';
testQuestions.q(2).correct   = 3;

testQuestions.q(3).question = 'What does Optical Fading mean?';
testQuestions.q(3).answer{1} = 'A napping field engineer';
testQuestions.q(3).answer{2} = 'Electrical signal in decline';
testQuestions.q(3).answer{3} = 'Low backscattered light causing large strain values';
testQuestions.q(3).answer{4} = 'Low light levels coming out of the laser';
testQuestions.q(3).correct   = 3;

testQuestions.q(4).question = 'What does a Quad Laser do?';
testQuestions.q(4).answer{1} = 'Improves the tone of the quadracepts with a laser treatment';
testQuestions.q(4).answer{2} = 'Use of 4 wavelengths of light to reduce optical fading';
testQuestions.q(4).answer{3} = 'An advanced laser which provides more light output';
testQuestions.q(4).answer{4} = 'Allows a backup in case lasers fail';
testQuestions.q(4).correct   = 2;

testQuestions.q(5).question = 'What are single and multi mode fibers?';
testQuestions.q(5).answer{1} = 'Additives to breakfast cereal';
testQuestions.q(5).answer{2} = 'Insulating material to keep the optical glass warm';
testQuestions.q(5).answer{3} = 'Events where light escapes the fiber';
testQuestions.q(5).answer{4} = 'Two types of fiber construction controling the paths of light';
testQuestions.q(5).correct   = 4;


testQuestions.q(6).question = 'What is Raman scattering?';
testQuestions.q(6).answer{1} = 'A non-linear interaction of light with the fiber which is very temperature sensitive';
testQuestions.q(6).answer{2} = 'A Japanese noodle dish that has spilled on the floor';
testQuestions.q(6).answer{3} = 'Defects in the laser which decrease the power';
testQuestions.q(6).answer{4} = 'Personnel need to run for safety when the laser overheats';
testQuestions.q(6).correct   = 1;

testQuestions.q(7).question = 'What is Brillouin scattering?';
testQuestions.q(7).answer{1} = 'An unprouncable French name';
testQuestions.q(7).answer{2} = 'A non-linear scattering sensitive to both strain and temperature';
testQuestions.q(7).answer{3} = 'A type of non-linear scraping of the fiber to enhance scattering';
testQuestions.q(7).answer{4} = 'French for Brillo brand steel wool pad';
testQuestions.q(7).correct   = 2;

testQuestions.q(8).question = 'To what does Stokes and anti-Stokes refer?';
testQuestions.q(8).answer{1} = 'The loading and unloading of energy';
testQuestions.q(8).answer{2} = 'The two types of non-linear interaction of light with the fiber';
testQuestions.q(8).answer{3} = 'Add more wood to the fire and then take it out if it is too hot';
testQuestions.q(8).answer{4} = 'Matter and antimatter that collect in the warp drive';
testQuestions.q(8).correct   = 2;

testQuestions.q(9).question = 'What is wireline deployed fiber?';
testQuestions.q(9).answer{1} = 'A wireline cable used to insert optical fiber into a well';
testQuestions.q(9).answer{2} = 'A way to send nutrients through small tubes';
testQuestions.q(9).answer{3} = 'A method of attaching fiber to the outside of a casing';
testQuestions.q(9).answer{4} = 'A method of cleaning out debris the borehole';
testQuestions.q(9).correct   = 1;

testQuestions.q(10).question = 'What is strain?';
testQuestions.q(10).answer{1} = 'A type of rain contaminated by the element strontium';
testQuestions.q(10).answer{2} = 'The decimal percentage change in length of a material due to an applied stress';
testQuestions.q(10).answer{3} = 'The fatique of too much work';
testQuestions.q(10).answer{4} = 'The particle velocity of light in a fiber';
testQuestions.q(10).correct   = 2;

testQuestions.q(11).question = 'What is gauage length?';
testQuestions.q(11).answer{1} = 'The width of the gate required to get equipment into the field';
testQuestions.q(11).answer{2} = 'The thickness of a fiber optic cable';
testQuestions.q(11).answer{3} = 'An estimate of the time it takes to acquire DAS data';
testQuestions.q(11).answer{4} = 'The distance used by the interferometer to compute the phase in the sensing fiber';
testQuestions.q(11).correct   = 4;

testQuestions.q(12).question = 'What does SEAFOM stand for?';
testQuestions.q(12).answer{1} = 'Sacred Engineering Association For Optical Meddling';
testQuestions.q(12).answer{2} = 'A foam used to clean optical fibers';
testQuestions.q(12).answer{3} = 'subSEA Forum for Optical Monitoring';
testQuestions.q(12).answer{4} = 'A small creature able to darken fiber in the well';
testQuestions.q(12).correct   = 3;

testQuestions.q(13).question = 'What is an interferometer?';
testQuestions.q(13).answer{1} = 'A device used to extract the phase between 2 optical signals';
testQuestions.q(13).answer{2} = 'The insides of a fuzzy animal called meter';
testQuestions.q(13).answer{3} = 'A device to prevent the interference between two signals';
testQuestions.q(13).answer{4} = 'The amount of collective fear about collecting DAS data by the field engineers';
testQuestions.q(13).correct   = 1;

testQuestions.q(14).question = 'What is DAS?';
testQuestions.q(14).answer{1} = 'Distinctly Attractive Scientists';
testQuestions.q(14).answer{2} = 'Distributed Acoustic Sensing';
testQuestions.q(14).answer{3} = 'Diffraction Applied Sound';
testQuestions.q(14).answer{4} = 'Ducks Assembled Singlefile';
testQuestions.q(14).correct   = 2;

end