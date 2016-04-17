#define __rose_lt(x,y) ((x)<(y)?(x):(y))
#define __rose_gt(x,y) ((x)>(y)?(x):(y))
//this is only  used for cuda-chill
//heavy simplification
#define NsolventMolecules_ 1024
#define NsolventAtoms_ 1024

struct MolDist 
{
///< Original solvent molecule number (starts from 1).
  int mol;
///< Closest distance of solvent molecule to atoms in distanceMask.
  double D;
//AtomMask mask;  ///< Original topology solvent molecule atom mask.
///< Actual solvent atom #s to loop over.
  double solventAtoms[1024][3];
}
;
//using dist for no image 
// and kernel for when we use solute molecule center
//extracting pulling out arrays out from struct 

void Action_NoImage_Center(struct MolDist SolventMols_[1024],double maskCenter[3],double maxD)
{
  double Dist;
  int solventMol;
  int solventAtom;
//Vec3 maskCenter = frmIn.VGeometricCenter( distanceMask_ );
//standard loop 
  for (solventMol = 0; solventMol < 1024; solventMol++) {
    SolventMols_[solventMol].D = maxD;
    for (solventAtom = 0; solventAtom < 1024; solventAtom++) {
//main dist2_noImage code
//double *a1 = maskCenter.Dptr(); //center of solute molecule
//double *a2 = frmIn.XYZ(*solvent_atom);
//double *a1 = maskCenter; //center of solute molecule
//double *a2 = SolventMols_[solventMol][solventAtom];  
//double x = a1[0] - a2[0];
//double y = a1[1] - a2[1];
//double z = a1[2] - a2[2];
//Dist = (x*x + y*y + z*z);
      Dist = maskCenter[0] * SolventMols_[solventMol].solventAtoms[solventAtom][0] + maskCenter[1] * SolventMols_[solventMol].solventAtoms[solventAtom][1] + maskCenter[2] * SolventMols_[solventMol].solventAtoms[solventAtom][2];
//D_[solventMol] = Dist < D_[solventMol] ?  Dist : D_[solventMol];
      if (Dist < SolventMols_[solventMol].D) 
        SolventMols_[solventMol].D = Dist;
    }
  }
}
