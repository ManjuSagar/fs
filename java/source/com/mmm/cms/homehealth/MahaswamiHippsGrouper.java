/*
 * Home Health Grouper
 * Developer for the Center for Medicare and Medicaid Services CMS
 * by 3M Health Information Systems.
 *
 * All code is provided as is.
 */
package com.mmm.cms.homehealth;

import com.mmm.cms.homehealth.ScoringResults;
import com.mmm.cms.homehealth.proto.HomeHealthGrouperFactoryIF;
import com.mmm.cms.homehealth.proto.HomeHealthGrouperIF;
import com.mmm.cms.homehealth.proto.HomeHealthRecordIF;
import com.mmm.cms.homehealth.proto.ScoringResultsIF;
import com.mmm.cms.util.HHEventConsole;
import com.mmm.cms.util.ScoringResultsFormatter;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.Writer;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.logging.ConsoleHandler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Properties;
import java.io.*;
import com.mmm.cms.homehealth.HomeHealthGrouperFactory;
import com.mmm.cms.homehealth.io.OasisRecordConverterIF;
import com.mmm.cms.homehealth.io.OasisXMLConverter;
import com.mmm.cms.homehealth.HomeHealthRecord;
import com.mmm.cms.homehealth.io.OasisReaderFactory;
import com.mmm.cms.homehealth.proto.ServiceIssueException;
import java.text.ParseException;

/**
 * This tests reading an OASIS-B/C set of records and scoring them using the
 * appropriate grouper provided by the grouper factory.
 *
 * This testing module represents the best example of how to access the Java
 * HHRG directly, without using the DLL bridge.
 *
 * There are parameters for this module that allow the details of a single
 * record to be displayed to the console. Refer to the inner class
 * CommandLineParams for more details.
 *
 *
 * @author 3M Health Information Systems
 */
public class MahaswamiHippsGrouper  {

    protected StringBuilder buffer;
    protected ScoringResultsIF scoringResultsEmpty;
    protected int hippsScoringEquation;
    protected int therapyNeedNumber;
    protected String timing;
    protected int clinicalPoints;
    protected int functionalPoints;
    protected int servicesUtilizationPoints;
    protected int nrsPoints;

    // this represents the end of file record
    protected ScoringResultsIF scoringBLANK = new ScoringResults((HomeHealthRecordIF)null);
    protected OasisReaderFactory readerFactory;
    public HomeHealthRecordIF recordEOF = new HomeHealthRecord();

    private HomeHealthGrouperFactoryIF grouperFactory;

    public MahaswamiHippsGrouper(String configPropertyFile) {
        buffer = new StringBuilder();
        scoringResultsEmpty = new ScoringResults((HomeHealthRecordIF)null);
        initGrouperFactory(configPropertyFile);
        readerFactory = new OasisReaderFactory();
    }

    private void initGrouperFactory(String configPropertyFile) {
        Properties props = null;
        try {
            props = new Properties();
            props.load(new FileInputStream(configPropertyFile));
        } catch (IOException ex) {
            Logger.getLogger(MahaswamiHippsGrouper.class.getName()).log(Level.SEVERE, "Could not open properties file: "
                    + configPropertyFile, ex);
        }
        grouperFactory = new HomeHealthGrouperFactory();
        if (props != null) {
            try {
                grouperFactory.init(props);
            } catch (Exception ex) {
                Logger.getLogger(MahaswamiHippsGrouper.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    /**
     * returns a HomeHealth record unless end of file, or an exception in
     * reading the file or parsing the record.
     *
     * @param inReader
     * @param curRecNum
     * @return
     */
    public HomeHealthRecordIF readRecord(BufferedReader inReader, int curRecNum) {
        HomeHealthRecordIF record = null;

        OasisRecordConverterIF recordConverter;
        try {
            final String strRecord;

            if ((strRecord = inReader.readLine()) != null) {
                recordConverter = readerFactory.getRecordConverter(strRecord);
                if (recordConverter != null) {
                    record = recordConverter.convertToHomeHealthRec(strRecord, curRecNum, true);
                    System.out.println(record.toString());
                }
            } else
                record = recordEOF;
        } catch (ParseException ex) {
            Logger.getLogger(MahaswamiHippsGrouper.class.getName()).log(Level.SEVERE, "Record " + curRecNum, ex);
        } catch (IOException ex) {
            Logger.getLogger(MahaswamiHippsGrouper.class.getName()).log(Level.SEVERE, "Record " + curRecNum, ex);
        }

        return record;
    }

    public String scoreNew(String exportText) throws ServiceIssueException, ParseException {
       System.out.println(exportText);
         BufferedReader br = new BufferedReader(new StringReader(exportText));
        /**HomeHealthRecordIF record = readRecord(br, 1); */
        OasisXMLConverter converter = new OasisXMLConverter();

        HomeHealthRecordIF record = converter.convertToHomeHealthRec(exportText, 1, true);
        therapyNeedNumber = record.getTHER_NEED_NBR();
        timing = record.getEPISODE_TIMING();
        ScoringResultsIF scoring = scoreRecord(grouperFactory, record);
        String hipps_code = scoring.getHIPPSCode().getCode();
        int[] points = scoring.getHIPPSCode().getPoints();
        int episodeTiming = points[0];
        int clinicalPoints = points[1];
        int functionalPoints = points[2];
        int servicePoints = points[3];
        int nrsPoints = points[4];
        String pointsArrayStr = String.valueOf(points[0])+","+String.valueOf(points[1])+","+String.valueOf(points[2])+","+String.valueOf(points[3])+","+String.valueOf(points[4]);
        String auth_code = scoring.getTreatmentAuthorization().getAuthorizationCode();
        String hipps_code_version = scoring.getGrouperVersion();
        String hipps =  hipps_code_version+","+hipps_code+","+auth_code;
        String result = hipps+","+pointsArrayStr;
        return result;
    }


    /**
     * Scores a single record
     * @param grouperFactory
     * @param record
     * @return
     */
    public ScoringResultsIF scoreRecord(
            HomeHealthGrouperFactoryIF grouperFactory, HomeHealthRecordIF record) throws ServiceIssueException {
        final HomeHealthGrouperIF grouper;
        ScoringResultsIF scoring;

        grouper = grouperFactory.getGrouper(record);
        if (grouper != null) {
            scoring = grouper.score(record, false);
        } else {
            scoring = scoringResultsEmpty;
        }
        return scoring;
    }

}
